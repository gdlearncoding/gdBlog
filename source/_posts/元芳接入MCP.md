---
title: 元芳接入MCP
date: 2025-10-02
tags:
  - LLM
  - 元芳
  - MCP
  - tools
categories: 果冻的航海日志
cover: ./img/logoZiyouzhiyi.jpg
---
# 项目特点(写在前面)
基于 Flask + MySQL + ChromaDB 的 工具管理系统 ,部署在虎符上,为元芳mcp-client工具提供服务，主要用于管理和搜索各种元芳工具，并集成MCP,向量检索,内含元芳执行器不依赖其他元芳版本只依赖数据库。
## 返回接口
执行失败
```JSON
{
    "log": [
        {
            "MCP_select_tool_name": "工具名称",
            "yf_tool_parameters": "参数"
        }
    ],
    "error": "错误信息或最终结果"
}
```
执行成功
```JSON
{
    "log": [
        {"name": "工具1", "description": "描述1"},
        {"name": "工具2", "description": "描述2"},
        {"name": "工具3", "description": "描述3"},
        {
	        "MCP_select_tool_name": "实际选择的工具名", 
	        "yf_tool_parameters": "具体参数"
	    }
    ],
    "response": "工具执行的具体结果内容"
}
```

## 类
```
Flask应用
├── CustomEmbeddingFunction (向量嵌入)
├── Tool (数据模型)
├── ToolCapability (工具管理)
│   ├── search_Tool() 向量搜索
│   └── get_tool() 工具详情
└── API路由
    ├── MCPClient (MCP集成)
    └── DashScopeClient (大模型交互)
```
### 主要类描述
#### 1. CustomEmbeddingFunction 类(出问题找王闯师兄,我只调用API)
- 功能 : 处理向量嵌入请求[[RAG]]
- 作用 : 向嵌入服务发送请求，将文本转换为向量表示
- 关键方法 : __call__() - 处理嵌入请求并返回向量
#### 2. Tool 类（数据库模型）
- 功能 : 定义工具数据表结构
- 作用 : 映射MySQL数据库中的tools表
- 包含字段 : id、name、description、parameters、host、method、url等工具配置信息
#### 3. ToolCapability 类(元芳执行器的调用方式,元芳能用该工具,我就能用)
- 功能 : 工具能力管理核心类
- 作用 : 管理ChromaDB连接和工具搜索功能
- 关键方法 :
  - __init__() - 初始化数据库连接
  - search_Tool() - 基于任务描述搜索相关工具
  - get_tool() - 从数据库获取工具详情
#### 4. MCPClient 类（在api_clients.py中）
- 功能 : MCP服务器客户端
- 作用 : 连接MCP服务器并处理工具调用
- 关键方法 : connect_to_server() , process_query()
#### 5. DashScopeClient 类（在api_clients.py中）
- 功能 : 通义千文API客户端
- 作用 : 与大模型进行对话交互
- 关键方法 : chat() - 发送聊天请求

## 以后的元芳工具描述格式
```
名称:[MCP]_[核心动作]_[目标对象]_[工具类型]
描述:
	功能说明：xxxxx
	输入参数：
	- xxx：xxxxxxx
	适用场景：
	- xxxxx
	- xxxxx
	- xxxxx
例如:
名称:[MCP]查询_虎符运行指标_Prometheus_服务
描述:
	功能说明：通过PromQL查询语句，获取获取虎符系统的各类运行指标数据。
	输入参数：
	- query：字符串，符合PromQL语法的Prometheus查询语句。
	适用场景：
	- 监控虎符系统运行状态
	- 排查虎符服务异常
	- 收集性能指标数据
```

### 工具的接入依靠
1）先是向量检索工具数据库中的描述和名称字段，筛选出三个符合的描述；
2）将这三个工具开放的接口连同用户的提问直接交给大模型，大模型会自动填充和调用工具，工具执行过程使用的是另一份元芳执行器的执行代码

## Qwen的MCP格式
```JSON
final_response
{
    "status_code": 200,                    # HTTP状态码
    "code": "Success",                     # 业务状态码
    "message": "success",                  # 业务消息
    "output": {                           # 主要输出内容
        "choices": [
            {
                "message": {
                    "role": "assistant",
                    "content": "模型生成的最终回答内容"
                }
            }
        ]
    },
    "usage": {                            # 使用统计
        "input_tokens": 100,
        "output_tokens": 50,
        "total_tokens": 150
    }
}

```

# 项目意义

由于MCP完美适配元芳的“应用-工具”模式, 如果使用MCP, 将不用在直接手动设定某个被调用的工具, MCP可以帮助我们选择工具, 并将参数自动填入, 最后将工具的结果变为自然语言, 我们就能很舒服的**通过问问题而调用元芳的所有工具**.

# 项目来历

2024年11月,MCP的诞生[[MCP]]
2025年4月,丁安然师姐[介绍MCP专题](https://www.bilibili.com/video/BV1Y1duYbEHo/?spm_id_from=333.1387.top_right_bar_window_custom_collection.content.click&vd_source=9465b0c882cf84738c83178da9a76207)
2025年5月,我开始尝试将MCP接入元芳,一开始使用OpenAI的模型,最后改为使用Qwen的模型
2025年7月,最后将元芳的工具描述补充完毕.
2025年9月,放完暑假,修改部分bug后, 最终将MCP上传Github[yuanfang-mcp](https://github.com/gaoguodong03/yuanfang-mcp)



<div style="position: relative; padding: 30% 45%;">

<iframe style="position: absolute; width: 100%; height: 100%; left: 0; top: 0;" src="//player.bilibili.com/player.html?isOutside=true&aid=114311175345762&bvid=BV1Y1duYbEHo&cid=29329656571&p=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true">
</iframe>

</div>


## 项目进度

一开始, 丁安然师姐在介绍MCP的时候直接通过API的调用接入了三个工具, 并手动添加了工具的描述,和元芳的关系不大, 只是作为演示.之后我便被徐老师安排将MCP接入元芳.

当时对元芳还不太熟悉,再加上代码能力不够,走了很多很多弯路, 写了很多垃圾代码. 最终确定了先画设计图,定义项目结构,最后再进行编程.
![[ObsidianPicture/Pasted image 20250930180205.png]]

这里附上我写的流程图(其中的问题已经全部解决了,只用关心流程)

![[ObsidianPicture/Pasted image 20250930180147.png]]
虽然,画了图,但是还是写了一坨屎山.主要原因还是不太熟悉元芳和虎符.

