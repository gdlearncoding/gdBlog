---
title: MCP(Model Context Protocol模型上下文协议)
date: 2025-09-30
tags:
  - LLM
  - tools
categories: 果冻的航海日志
---
MCP 起源于 2024 年 11 月 25 日, 定义了应用程序和 AI 模型之间交换上下文信息的方式。这使得开发者能够**以一致的方式将各种数据源、工具和功能连接到 AI 模型**（一个中间协议层），就像 USB-C 让不同设备能够通过相同的接口连接一样。MCP 的目标是创建一个通用标准，使 AI 应用程序的开发和集成变得更加简单和统一。

# 起源思考

我认为 MCP 的出现是 prompt engineering 发展的产物。更结构化的上下文信息对模型的 performance 提升是显著的。在构造 prompt 时，希望能提供一些更 specific 的信息（比如本地文件，数据库，一些网络实时信息等）给模型，这样模型更容易理解真实场景中的问题。

第一阶段手工输入. **想象一下没有 MCP 之前我们会怎么做**？我们可能会人工从数据库中筛选或者使用工具检索可能需要的信息，手动的粘贴到 prompt 中。随着我们要解决的问题越来越复杂，**手工**把信息引入到 prompt 中会变得越来越困难。

第二阶段 function call. 为了克服手工 prompt 的局限性，许多 LLM 平台（如 OpenAI、Google）引入了 `function call` 功能。这一机制允许模型在需要时调用预定义的函数来获取数据或执行操作。但是 function call 依赖平台, 不同 LLM 平台的 function call API 实现差异较大。例如，OpenAI 的函数调用方式与 Google 的不兼容，开发者在切换模型时需要重写代码.

第三阶段 MCP. **数据与工具本身是客观存在的**，只不过我们希望将数据连接到模型的这个环节可以更智能更统一。Anthropic 基于这样的痛点设计了 MCP，充当 AI 模型的"万能转接头"，让 LLM 能轻松的获取数据或者调用工具.


# 原理

先说过程:用户在 Claude 客户端（如 Claude Desktop、Cursor）输入问题后，客户端会先将问题发送给 Claude 大模型；Claude 接收问题后，会分析当前可用的工具（如文档解析、数据查询等）并确定需调用的工具类型及数量；接着客户端通过 MCP Server（模型上下文协议服务端），以标准化方式执行 Claude 选定的工具；工具执行完成后，其处理结果会通过 MCP 回传给 Claude；Claude 再结合用户原始问题与工具执行结果，构建最终的 Prompt 并生成自然语言回应；最后，客户端将这份回应展示给用户，完成整个交互流程。

## 关于模型如何选择工具

模型是通过 prompt 来确定当前有哪些工具。我们通过**将工具的具体使用描述以文本的形式传递给模型**，供模型了解有哪些工具以及结合实时情况进行选择。参考代码中的注释：

```python
 ... # 省略了无关的代码
 async def start(self):
     # 初始化所有的 mcp server
     for server in self.servers:
         await server.initialize()
 ​
     # 获取所有的 tools 命名为 all_tools
     all_tools = []
     for server in self.servers:
         tools = await server.list_tools()
         all_tools.extend(tools)
 ​
     # 将所有的 tools 的功能描述格式化成字符串供 LLM 使用
     # tool.format_for_llm() 我放到了这段代码最后，方便阅读。
     tools_description = "\n".join(
         [tool.format_for_llm() for tool in all_tools]
     )
 ​
     # 这里就不简化了，以供参考，实际上就是基于 prompt 和当前所有工具的信息
     # 询问 LLM（Claude） 应该使用哪些工具。
     system_message = (
         "You are a helpful assistant with access to these tools:\n\n"
         f"{tools_description}\n"
         "Choose the appropriate tool based on the user's question. "
         "If no tool is needed, reply directly.\n\n"
         "IMPORTANT: When you need to use a tool, you must ONLY respond with "
         "the exact JSON object format below, nothing else:\n"
         "{\n"
         '    "tool": "tool-name",\n'
         '    "arguments": {\n'
         '        "argument-name": "value"\n'
         "    }\n"
         "}\n\n"
         "After receiving a tool's response:\n"
         "1. Transform the raw data into a natural, conversational response\n"
         "2. Keep responses concise but informative\n"
         "3. Focus on the most relevant information\n"
         "4. Use appropriate context from the user's question\n"
         "5. Avoid simply repeating the raw data\n\n"
         "Please use only the tools that are explicitly defined above."
     )
     messages = [{"role": "system", "content": system_message}]
 ​
     while True:
         # Final... 假设这里已经处理了用户消息输入.
         messages.append({"role": "user", "content": user_input})
 ​
         # 将 system_message 和用户消息输入一起发送给 LLM
         llm_response = self.llm_client.get_response(messages)
 ​
     ... # 后面和确定使用哪些工具无关
     
 ​
 class Tool:
     """Represents a tool with its properties and formatting."""
 ​
     def __init__(
         self, name: str, description: str, input_schema: dict[str, Any]
     ) -> None:
         self.name: str = name
         self.description: str = description
         self.input_schema: dict[str, Any] = input_schema
 ​
     # 把工具的名字 / 工具的用途（description）和工具所需要的参数（args_desc）转化为文本
     def format_for_llm(self) -> str:
         """Format tool information for LLM.
 ​
         Returns:
             A formatted string describing the tool.
         """
         args_desc = []
         if "properties" in self.input_schema:
             for param_name, param_info in self.input_schema["properties"].items():
                 arg_desc = (
                     f"- {param_name}: {param_info.get('description', 'No description')}"
                 )
                 if param_name in self.input_schema.get("required", []):
                     arg_desc += " (required)"
                 args_desc.append(arg_desc)
 ​
         return f"""
 Tool: {self.name}
 Description: {self.description}
 Arguments:
 {chr(10).join(args_desc)}
 """
```
因此 描述工具的文本input_schema是我们要写的.  大部分情况下，当使用装饰器 `@mcp.tool()` 来装饰函数时，对应的 `name` 和 `description` 等其实直接源自用户定义函数的函数名以及函数的 `docstring` 等。
```python
 @classmethod
 def from_function(
     cls,
     fn: Callable,
     name: str | None = None,
     description: str | None = None,
     context_kwarg: str | None = None,
 ) -> "Tool":
     """Create a Tool from a function."""
     func_name = name or fn.__name__ # 获取函数名
 ​
     if func_name == "<lambda>":
         raise ValueError("You must provide a name for lambda functions")
 ​
     func_doc = description or fn.__doc__ or "" # 获取函数 docstring
     is_async = inspect.iscoroutinefunction(fn)
     
     ... # 更多请参考原始代码...
```
**模型是通过 prompt engineering，即提供所有工具的结构化描述和 few-shot 的 example 来确定该使用哪些工具**。

### 工具执行与结果反馈机制

其实工具的执行就比较简单和直接了。承接上一步，我们把 system prompt（指令与工具调用描述）和用户消息一起发送给模型，然后接收模型的回复。当模型分析用户请求后，它会决定是否需要调用工具：

- **无需工具时**：模型直接生成自然语言回复。
- **需要工具时**：模型输出结构化 JSON 格式的工具调用请求。

如果回复中包含结构化 JSON 格式的工具调用请求，则客户端会根据这个 json 代码执行对应的工具。具体的实现逻辑都在 `process_llm_response` 中，[代码](https://link.zhihu.com/?target=https%3A//github.com/modelcontextprotocol/python-sdk/blob/main/examples/clients/simple-chatbot/mcp_simple_chatbot/main.py%23L295-L338)，逻辑非常简单。

如果模型执行了 tool call，则工具执行的结果 `result` 会和 system prompt 和用户消息一起**重新发送**给模型，请求模型生成最终回复。

如果 tool call 的 json 代码存在问题或者模型产生了幻觉怎么办呢？通过阅读[代码](https://link.zhihu.com/?target=https%3A//github.com/modelcontextprotocol/python-sdk/blob/main/examples/clients/simple-chatbot/mcp_simple_chatbot/main.py%23L295-L338) 发现，我们会 skip 掉无效的调用请求。


