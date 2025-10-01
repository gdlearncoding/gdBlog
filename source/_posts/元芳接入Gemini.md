---
title: 元芳接入Gemini大模型
date: 2025-10-01
tags:
  - LLM
  - 元芳
categories: 果冻的航海日志
---
# 写在前面 我的实现方式
gemini是google的 所以需要注册google对应的账号,由于需要翻墙再加上需要资金往来,所以放弃这条路了.
最后选择使用国内的代理网站 [简易](https://jeniya.top/console/topup),调用了一个 API 接口, 确实挺好用的.[注册链接](https://jeniya.top/register?aff=tUUD)https://jeniya.top/register?aff=tUUD
# 了解Gemini

## 历程
2023 年 4 月，谷歌母公司 Alphabet 首席执行官桑达尔・皮查伊合并了两个大型人工智能团队，开启 OpenAI 计划。2023 年 12 月 6 日，谷歌正式推出 Gemini 1.0 版本，包括 Gemini Ultra、Gemini Pro 和 Gemini Nano 三个不同规格。2024 年 2 月 15 日，谷歌发布 Gemini 1.5，后续又不断对其进行升级和优化，如 2024 年 5 月 15 日更新升级 Gemini 1.5 Pro 版本，同时推出 Gemini 1.5 Flash 轻量化小模型。2025 年 3 月 26 日，谷歌正式推出新一代人工智能推理模型 Gemini 2.5。

## **模型规格及特点**

**Gemini Ultra**：是 Gemini 中能力最强的模型，适用于处理高度复杂的任务，如在各种推理和多模态任务中表现出色。它在 MMLU 基准测试中的得分率高达 90.0%，首次超越了人类专家。

 **Gemini Pro**：适用于多任务，在成本和延迟方面进行了性能优化，具有推理功能和广泛的多模态能力，可在广泛的任务范围内提供显著的性能。

**Gemini Nano**：是最高效的模型，用于特定任务和移动设备。该模型训练了两个版本的 Nano，参数分别为 1.8B（Nano-1）和 3.25B（Nano-2），分别针对低内存和高内存器件，采用 4 位量化部署。
# 本次接入Gemini 2.5 系列模型

### 🔥 gemini-2.5-flash-lite

- **速度**: 最快响应时间
- **成本**: 最经济实惠
- **能力**: 基础文本理解和生成
- **最佳用途**: 聊天机器人、简单问答、内容摘要

### ⚡ gemini-2.5-flash

- **速度**: 快速响应
- **成本**: 平衡性价比
- **能力**: 文本+图像理解，多模态基础任务
- **最佳用途**: 通用AI应用、客户服务、内容创作

### 🎯 gemini-2.5-pro

- **速度**: 响应较慢但质量最高
- **成本**: 最高定价
- **能力**: 复杂推理、专业分析、多模态高级任务
- **最佳用途**: 研究分析、代码生成、复杂问题解决

### 🖼️ gemini-2.5-flash-image-preview

- **速度**: 针对图像优化
- **成本**: 中等定价
- **能力**: 专业图像识别、视觉分析
- **最佳用途**: 图像描述、OCR、视觉内容分析

## 选择建议

1. **预算敏感**: 选择 flash-lite
2. **平衡需求**: 选择 flash
3. **高质量要求**: 选择 pro
4. **图像处理**: 选择 flash-image-preview

## 输出接口

```JSON
{
  "system_instruction": {
    "parts": [
      {
        "text": "You are an asistant."
      }
    ]
  },
  "contents": [
    {
      "role": "user",
      "parts": [
        {
          "text": "${content}"
        }
      ]
    }
  ]
}
```

## 官方接口
官方文档：[https://ai.google.dev/gemini-api/docs/text-generation?hl=zh-cn#multi-turn-conversations](https://ai.google.dev/gemini-api/docs/text-generation?hl=zh-cn#multi-turn-conversations)