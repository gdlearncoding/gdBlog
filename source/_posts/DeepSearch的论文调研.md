---
title: DeepSearch的论文调研
date: 2025-10-01
tags:
  - LLM
  - DeepSearch
  - 调研
categories: 果冻的理论学习
cover: ./img/logoZiyouzhiyi.jpg
---
## 论文调研

[综述论文A Comprehensive Survey of Deep Research: Systems, Methodologies, and Applications](https://arxiv.org/pdf/2506.12594)
该综述由浙江大学徐仁军和彭静雯撰写，系统研究了**Deep Research 系统**这一快速发展的领域 —— 这类系统通过整合**大型语言模型（LLMs）、先进信息检索技术和自主推理能力**，实现复杂研究工作流的自动化；综述分析了 2023 年以来出现的**80 多个商业和非商业系统**（如 OpenAI/DeepResearch、Gemini/DeepResearch 等），提出了基于 “基础模型与推理引擎、工具利用与环境交互、任务规划与执行控制、知识合成与输出生成” 的**四层技术分类体系**，探讨了系统在学术、科学、商业、教育等领域的架构模式与应用适配性，指出当前系统在信息准确性、隐私、知识产权等方面的技术与伦理挑战，并明确了先进推理架构、多模态融合、领域专业化等**未来研究方向**，同时提供了相关资源库（[https://github.com/scienceaix/deepresearch](https://github.com/scienceaix/deepresearch)）支持进一步研究

![[ObsidianPicture/Pasted image 20251001221837.png]]

```xmind
## **综述基础信息**
- 作者：浙江大学 Renjun Xu、Jingwen Peng
- 核心对象：Deep Research系统
- 研究范围：2023年以来80+商业/非商业系统
- 资源库：https://github.com/scienceaix/deepresearch
## **Deep Research定义与边界**
- 核心维度
  - 智能知识发现：自动化文献检索、假设生成
  - 端到端工作流自动化：实验设计-数据收集-分析-解读
  - 协作智能增强：人机协作接口、可视化
- 边界区分
  - ≠通用AI助手（缺自主工作流能力）
  - ≠单功能研究工具（缺跨功能整合）
  - ≠纯LLM应用（缺工具集成与环境交互）
## **技术框架与演进**
- 基础模型与推理引擎
  - 演进：通用LLM→研究专用模型（如OpenAI o3、Gemini 2.5 Pro）
  - 关键能力：百万级token上下文窗口、链/树状推理
- 工具利用与环境交互
  - 网页交互：从API搜索→动态内容处理（如Nanobrowser）
  - 内容处理：从文本提取→多模态解析（PDF、表格、可视化）
  - 工具集成：从通用API→16000+专用API（ToolLLM支持）
- 任务规划与执行控制
  - 规划：线性分解→分层动态规划（如OpenAI/AgentsSDK）
  - 执行： sequential执行→并发监控+故障恢复（如Agent-RL/ReSearch）
  - 协作：单智能体→多智能体分工（如smolagents/open_deep_research）
- 知识合成与输出生成
  - 信息评估：源信誉→多维度质量验证（如grapeot/deep_research_agent）
  - 报告生成：简单总结→结构化报告+引用（如mshumer/OpenDeepResearcher）
  - 交互呈现：静态文本→动态探索界面（如HKUDS/Auto-Deep-Research）
## **系统比较与评估**
- 技术维度比较
  - 基础模型：上下文长度（Gemini 2.5 Pro达1M tokens）、推理方式
  - 环境交互：网页/API/文档/GUI支持能力
  - 规划执行：任务分解、错误处理、多智能体协作
  - 知识合成：源评估、输出结构、用户交互
- 应用适配分析
  - 学术研究：文献综述、假设生成（OpenAI/DeepResearch适配）
  - 商业智能：市场分析、战略决策（Gemini/DeepResearch适配）
  - 个人知识管理：信息整理、学习规划（Perplexity/DeepResearch适配）
- 性能基准
  - 定量：HLE（OpenAI/DeepResearch达26.6%）、GAIA（Manus达86.5%）、MMLU（Grok3Beta达92.7%）
  - 定性：输出连贯性、信息多样性、验证机制
## **挑战与未来方向**
- 关键挑战
  - 信息准确性：幻觉、事实一致性
  - 隐私安全：用户数据隔离、敏感信息保护
  - 知识产权：引用完整性、版权合规
  - 可及性：计算资源依赖、技术门槛
- 未来方向
  - 先进推理：神经符号融合、因果推理、不确定性建模
  - 多模态：视觉/音频/视频整合、跨模态推理
  - 领域专业化：科学/法律/医疗定制优化
  - 人机协作：交互工作流、标准接口、联合知识创建
```

### 一、综述基础与研究背景

**核心定义**

Deep Research 系统是一类 AI 驱动应用，通过整合**大型语言模型（LLMs）、先进信息检索技术和自主推理能力**，实现复杂研究工作流的自动化，核心覆盖 “智能知识发现、端到端工作流自动化、协作智能增强” 三大维度，需与通用 AI 助手（如 ChatGPT）、单功能工具（如文献管理器）、纯 LLM 应用区分 —— 后者缺乏跨功能整合与自主工作流能力。

 **研究意义**

学术创新：加速假设验证（如 HotpotQA 基准任务），挖掘跨学科关联
企业转型：支持大规模数据驱动决策（如 Agent-RL/ReSearch 分析市场趋势）
知识民主化：通过开源系统（如 grapeot/deep_research_agent）降低技术门槛

### 二、Deep Research 系统的技术框架与演进

#### 2.1 四层技术分类体系（核心框架）

| 技术维度      | 核心能力演进                                          | 代表系统 / 技术                                                                                         |
| --------- | ----------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| 基础模型与推理引擎 | 通用 LLM→研究专用模型；有限上下文→百万级 token 窗口；零样本推理→链 / 树状推理 | OpenAI o3（200k tokens）、Gemini 2.5 Pro（1M tokens）、AutoGLM-Research                                 |
| 工具利用与环境交互 | API 搜索→动态网页导航；文本提取→多模态处理；通用工具→16000 + 专用 API 集成 | Nanobrowser（AI 专用浏览器）、dzhng/deep-research（多格式文档处理）、ToolLLM                                        |
| 任务规划与执行控制 | 线性任务分解→分层动态规划； sequential 执行→并发监控；单智能体→多智能体协作   | OpenAI/AgentsSDK（分层规划）、Agent-RL/ReSearch（强化学习执行）、TARS（多智能体）                                       |
| 知识合成与输出生成 | 源信誉判断→多维度验证；简单总结→结构化报告；静态文本→动态交互呈现              | grapeot/deep_research_agent（证据评估）、mshumer/OpenDeepResearcher（报告生成）、HKUDS/Auto-Deep-Research（交互探索） |

#### 2.2 系统演进三阶段（2023-2025）

1. **起源与早期探索（2023-2025.2）**
    
    - 技术基础：基于 n8n（工作流自动化）、AutoGPT（智能体框架）等现有工具
    - 里程碑：2024.12 Google Gemini 推出首个 Deep Research 功能，支持基础多步推理
    - 代表系统：cline2024（集成研究工作流）、open_operator（浏览器自动化）
2. **技术突破与竞争（2025.2-2025.3）**
    
    - 关键事件：DeepSeek 开源模型（高效推理）、OpenAI/DeepResearch（o3 模型驱动，准确率超基准）、Perplexity/DeepResearch（免费开放，侧重快速响应）
    - 开源生态：nickscamara/open-deepresearch、mshumer/OpenDeepResearcher、GPT-researcher
3. **生态扩展与多模态融合（2025.3 - 至今）**
    
    - 核心进展：本地化部署（Jina-AI/node-DeepResearch）、多模态支持（Gemini/DeepResearch）、多智能体协作（Camel-AI/OWL）
    - 新参与者：Anthropic Claude/Research（2025.4，支持可验证引用）、Manus、AutoGLM-Research

### 三、系统比较与评估分析

#### 3.1 核心系统技术参数对比

|系统名称|基础模型|上下文长度|关键能力亮点|典型应用场景|
|---|---|---|---|---|
|OpenAI/DeepResearch|o3|最高 200k tokens|多步推理、学术数据库集成、高准确率报告|学术研究、金融分析|
|Gemini/DeepResearch|Gemini 2.5 Pro|1M tokens|多模态处理、多智能体协作、长文本分析|科学发现、商业智能|
|Perplexity/DeepResearch|DeepSeek-R1|128K tokens|实时源聚合、免费访问、快速响应|个人知识管理、市场趋势|
|Manus|未明确|未明确|150 + 服务集成、战略决策支持|企业商业分析|
|AutoGLM-Research|ChatGLM|依赖模型（DOM）|GUI 交互、移动端支持、本地部署|个性化学习、小范围研究|

#### 3.2 性能基准表现（定量指标）

|系统名称|HLE 得分（%）|MMLU 得分（%）|GAIA（pass@1，%）|HotpotQA 得分（%）|
|---|---|---|---|---|
|OpenAI/DeepResearch|26.6|-|67.36|-|
|Gemini 2.5 Pro|18.8|-|-|-|
|Perplexity/DeepResearch|21.1|-|-|-|
|Grok3Beta|-|92.7|-|-|
|Manus|-|-|86.5|-|
|Agent-RL/ReSearch|-|-|-|37.51|

#### 3.3 应用领域适配性

1. **学术研究**：OpenAI/DeepResearch、Camel-AI/OWL 表现突出，支持 ArXiv、PubMed 等数据库集成，能识别研究方法、生成 IEEE/APA 格式引用，适配文献综述、假设生成场景。
2. **商业智能**：Gemini/DeepResearch、Manus 擅长市场分析（SEC 文件、行业报告）、SWOT 框架应用，输出可直接用于战略决策的 executive summary。
3. **教育领域**：HKUDS/Auto-Deep-Research、OpenManus 提供个性化学习路径，支持多难度解释（适配不同知识水平学习者），辅助课程设计与研究技能培训。
4. **个人知识管理**：Perplexity/DeepResearch（多设备支持）、nickscamara/open-deep-research（本地文件集成），适配信息整理、兴趣驱动学习场景。

### 四、技术挑战与伦理考量

1. **技术挑战**
    
    - 信息准确性：LLM 幻觉问题，需通过多源验证（如 Perplexity 的源多样性过滤）、矛盾检测（如 Gemini 的不确定性建模）缓解
    - 计算效率：商业系统（如 OpenAI）响应时间 5-30 分钟，开源系统（如 nickscamara/open-deepresearch）资源需求高，本地部署需优化
    - 系统集成：工具链兼容性（如 API 版本差异）、跨平台部署（桌面 / 移动端适配）
2. **伦理问题**
    
    - 隐私安全：用户查询隔离（商业系统）、本地部署支持（开源系统如 OpenManus），需合规 GDPR、CCPA 等法规
    - 知识产权：引用完整性（如 OpenAI 的语句级引用链接）、版权合规（如 Jina-AI 的许可证分类）
    - 可及性：计算资源门槛（需 GPU 支持）、技术 expertise 要求（开源系统部署复杂），可能加剧数字鸿沟

### 五、未来研究方向

1. **先进推理架构**：神经符号融合（结合逻辑推理与 LLM）、因果推理（干预建模）、外部记忆框架（突破上下文限制）
2. **多模态融合**：科学图像分析（图表 / 实验图像）、视频 / 音频内容处理（学术讲座、实验演示）、跨模态一致性验证
3. **领域专业化**：科学领域（物理 / 化学专用模型）、法律领域（案例推理、合规分析）、医疗领域（临床证据合成、个性化适配）
4. **人机协作与标准化**：交互工作流（动态查询优化）、通用接口协议（如 Anthropic MCP、Google A2A）、联合知识创建（人机协同报告生成）

---

##  一些思考

### 问题 1：Deep Research 系统与传统 AI 助手（如 ChatGPT）的核心区别是什么？这些区别如何影响其在学术研究中的应用价值？

核心区别体现在三个维度：

1. **工作流能力**：Deep Research 系统支持 “文献检索 - 实验设计 - 数据分析 - 报告生成” 的端到端自动化，如 OpenAI/DeepResearch 可整合 ArXiv 文献与统计工具；传统 AI 助手仅能响应单次查询，无法自主串联多步研究任务。
2. **工具与环境交互**：Deep Research 可集成 16000 + 专用 API（ToolLLM 支持）、动态网页导航（如 Nanobrowser）、多格式文档处理（PDF / 表格）；传统 AI 助手缺乏工具调用能力，依赖用户手动输入信息。
3. **推理深度**：Deep Research 采用链 / 树状推理（如 Gemini 的树状推理）、百万级 token 上下文（Gemini 2.5 Pro 达 1M tokens），能处理长文本与复杂逻辑；传统 AI 助手推理链短，上下文窗口有限（如 ChatGPT 免费版 4k tokens）。

这些区别使 Deep Research 在学术研究中更具价值：可自动化系统综述（处理数千篇文献）、识别研究方法漏洞、生成带可验证引用的报告，大幅降低手动工作量，如 OpenAI/DeepResearch 在医学研究中分析数千篇论文以识别干预 efficacy 模式。

### 问题 2：当前主流 Deep Research 系统（商业与开源）在技术性能与应用适配性上有何差异？企业与学术用户应如何选择？

**答案**：商业与开源系统的差异及选择建议如下：

#### （1）技术性能差异

|维度|商业系统（如 OpenAI/DeepResearch）|开源系统（如 dzhng/deepresearch）|
|---|---|---|
|基础模型|专用模型（o3、Gemini 2.5 Pro），性能领先|通用模型（ChatGLM、DeepSeek-R1），需优化|
|响应时间|5-30 分钟（复杂任务）|更长（依赖本地硬件，需 10 + 分钟）|
|准确率（HLE 基准）|26.6%（OpenAI）、21.1%（Perplexity）|未公开，实测低于商业系统|
|维护与更新|自动迭代（如 OpenAI o3→o4-mini）|依赖社区贡献，更新频率低|

#### （2）应用适配性差异

- 商业系统：适配大规模学术研究（多数据库集成）、企业商业分析（实时市场数据），适合对准确率、稳定性要求高的场景，如药企的临床文献综述、跨国企业的竞品分析。
- 开源系统：支持本地化部署（数据隐私敏感场景）、定制化开发（如添加领域专用工具），适合预算有限的学术团队（小范围课题研究）、企业内部敏感数据处理（如内部报告生成）。

#### （3）选择建议

- 学术用户：若需处理大规模文献（如系统综述）、依赖高准确率（如假设验证），选择商业系统（如 OpenAI/DeepResearch）；若数据敏感（如未发表实验数据）、需定制工具链，选择开源系统（如 HKUDS/Auto-Deep-Research）。
- 企业用户：若需实时市场分析（如 Perplexity 的快速响应）、多部门协作（如 Gemini 的多智能体功能），选择商业系统；若需本地化部署（合规要求）、低成本扩展，选择开源系统（如 Jina-AI/node-DeepResearch）。

### 问题 3：当前 Deep Research 系统在解决 “信息准确性” 与 “幻觉” 问题上有哪些关键技术手段？这些手段的局限性是什么？未来可如何改进？

**答案**：当前关键技术手段、局限性及改进方向如下：

#### （1）当前技术手段

1. **多源验证**：商业系统（如 OpenAI/DeepResearch）要求关键结论需 2 + 独立源支持，Perplexity/DeepResearch 通过 “源多样性过滤”（跨平台聚合信息）降低单一源偏差；开源系统（如 grapeot/deep_research_agent）采用源可信度评分（基于发布机构、引用量）。
2. **引用与溯源**：OpenAI/DeepResearch 实现 “语句级引用链接”，每个结论可跳转至原始文献 / 数据；mshumer/OpenDeepResearcher 生成结构化报告，明确标注引用来源与 DOI。
3. **不确定性建模**：Gemini/DeepResearch 区分 “确认信息” 与 “推测内容”，用置信度指标（如高 / 中 / 低）标注结论可靠性；Agent-RL/ReSearch 通过 “矛盾检测算法” 识别冲突信息并提示用户。

#### （2）局限性

1. **多源验证**：依赖源的可用性（如小众领域文献少，无法多源交叉），且无法识别 “同源信息重复”（如不同平台转载同一研究）。
2. **引用机制**：仅覆盖公开源（如 ArXiv、PubMed），企业内部报告、未发表数据等私有信息无法溯源；引用格式易出错（如开源系统的 BibTeX 导出可能遗漏字段）。
3. **不确定性建模**：置信度指标缺乏统一标准（商业系统各自定义），用户难以判断 “低置信度” 是否需进一步验证；无法处理 “证据不足” 场景（如新兴研究领域无足够数据支持结论）。

#### （3）未来改进方向

1. **证据质量评估细化**：引入领域专用指标，如学术研究中结合 “研究方法严谨性”（样本量、随机对照设计）、商业分析中结合 “数据时效性”（市场数据发布时间）评估源质量。
2. **动态溯源框架**：支持私有源（如企业数据库、实验室内部系统）的权限管理与溯源，通过区块链技术确保引用不可篡改。
3. **人机协同验证**：设计交互接口，如 HKUDS/Auto-Deep-Research 的 “矛盾提示 - 用户决策” 流程，让用户参与高不确定性结论的验证，同时记录反馈以优化模型判断。