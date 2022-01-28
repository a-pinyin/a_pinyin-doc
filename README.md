# A 拼音输入法 (文档)

<https://github.com/fm-elpac/a_pinyin>

TODO **注意**: 目前本项目还在早期阶段, 下述只是计划.

## A 拼音特点

- **完全开源**

  GPLv3 许可证, 将用户的需求放在第一位, 没有恶意.

- **离线运行**

  所有计算均在本地进行, 运行过程中不连网 (app 没有申请联网权限),
  "无痕模式" 更好的保护用户隐私.

- **支持多个平台**

  Android (8.1+ armv7/aarch64v8), GNU/Linux (ibus), Windows (10)

- **技术先进**

  c2 核心采用类似 BERT 的预训练语言模型, c3 核心支持离线语音输入,
  享受前沿 AI 发展成果.

## 主要功能

- 拼音输入 (全拼, 双拼, 简拼)

- 语音输入 (普通话)

- 字符输入 (数字, 字母, 符号)

- 用户词典/自定义输入

- 无痕模式

- 剪切板管理

- 多种键盘布局 (qwerty, dvorak, abcd, 自定义)

- 开放输入接口 (远程输入)

## A 拼音核心

- **c1** 基础核心: 词典/缓存模型

  速度快运算量小, 适配资源较少的设备.

- **c2** 高级核心: 预训练语言模型

  使用先进的自然语言处理 (NLP) 技术.

- **c3** 语音核心: 离线语音输入

  无需联网, 解放双手.

## 相关代码仓库

| 仓库            | 说明                                | 编程语言/框架                 | LICENSE      |
| :-------------- | :---------------------------------- | :---------------------------- | :----------- |
| a_pinyin        | (本仓库) 主要文档                   | markdown                      | CC-BY-SA 4.0 |
| a_pinyin-server | 后端等模块, apy                     | rust, WASM (wasmer)           | GPLv3        |
| a_pinyin-apk    | 基于 flutter 的界面 (前端, Android) | dart, flutter, wasmer, kotlin | GPLv3        |
| a_pinyin-ui     | 基于 web 的界面 (前端, Windows)     | TypeScript, rust, tauri       | GPLv3        |
| a_pinyin-ibus   | 适配 ibus (前端, Linux)             | ?                             | GPLv3        |
| a_pinyin-data   | c1 核心的内置数据及数据处理工具     | rust, sqlite                  | CC-BY-SA 4.0 |
| a_pinyin-c2     | c2 核心                             | ?                             | ?            |
| a_pinyin-c3     | c3 核心                             | ?                             | ?            |

TODO

## 友情链接

TODO

## LICENSE

[`CC-BY-SA 4.0+`](https://creativecommons.org/licenses/by-sa/4.0/)

本仓库的内容使用 创意共享-署名-相同方式共享 (CC-BY-SA 4.0) 许可证 (LICENSE).
This repository is released under Creative Common (CC-BY-SA 4.0) license.
