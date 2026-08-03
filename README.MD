# 贵州大学研究生学位论文模板

贵州大学研究生学位论文模板，随仓附赠 答辩 beamer、盲审意见回复模版和答辩讲稿模版。

当前版本主要依据贵州大学研究生院 2026 年 3 月 9 日发布的[《关于规范贵州大学研究生学位论文写作格式的通知》](https://gs.gzu.edu.cn/2026/0309/c11824a265403/page.htm)及其附件《贵州大学研究生学位论文格式》调整。

## 项目信息（GitHub）

[![GitHub Repo](https://img.shields.io/badge/GitHub-francisol%2FGZUthesis--template-181717?logo=github&logoColor=white)](https://github.com/francisol/GZUthesis-template)
[![GitHub stars](https://img.shields.io/github/stars/francisol/GZUthesis-template)](https://github.com/francisol/GZUthesis-template)
[![GitHub issues](https://img.shields.io/github/issues/francisol/GZUthesis-template)](https://github.com/francisol/GZUthesis-template/issues)
[![Overleaf 模板](https://img.shields.io/badge/Overleaf-在线模板-green?logo=overleaf&logoColor=white)](https://www.overleaf.com/latex/templates/gui-zhou-da-xue-yan-jiu-sheng-bi-ye-lun-wen-mo-ban/tstnysppbxvh)

- 仓库地址：<https://github.com/francisol/GZUthesis-template>
- 问题反馈、使用建议：请在 [GitHub Issues](https://github.com/francisol/GZUthesis-template/issues) 提交。


## 仓库结构

| 文件/目录 | 说明 |
| --- | --- |
| `GZUthesis.cls` | 学位论文模板宏包 |
| `metadata.tex` | 论文元数据文件，集中填写题名、作者、专业、导师、答辩委员会、承诺书日期与签名图片等信息 |
| `final_thesis.tex` | 主论文入口 |
| `defense_committee.tex` | 答辩委员会名单单独打印入口 |
| `chapter/` | 章节文件目录（摘要、绪论、致谢、附录示例） |
| `reference.bib` | 参考文献数据库 |
| `logo/` | 校徽、承诺书底图等模板资源目录，签名图片也可放在这里 |
| `GZUthesis.tex` | 模板使用手册（用户文档） |
| `response.tex` | 盲审意见回复示例 |
| `reviewresponse.cls` | 盲审意见回复文档类 |
| `reviewresponse-content.sty` | 盲审意见回复正文语义命令与“修改概况”页 |
| `defensespeech.cls` | 答辩讲稿文档类 |
| `beamer/` | 答辩 beamer 模板 |
| `out/` | latexmk 编译输出目录，自动生成 |

## 快速开始

一般只需要修改 `metadata.tex` 和各章节文件，不建议把论文元数据散落在多个入口中。

1. 修改 `metadata.tex` 中的论文题名、作者、专业、导师、答辩委员会等信息，并按需配置承诺书日期和签名图片。
2. 在 `chapter/abstract.tex`、`chapter/intro.tex` 等章节文件中撰写正文。
3. 在 `reference.bib` 中维护参考文献。
4. 编译主论文；若只需要打印答辩委员会名单，则单独编译 `defense_committee.tex`（见下文“编译”一节）。

## 论文模板

基于 book 制作，使用 xelatex 编译，本模板在 Overleaf 上同步更新：[Overleaf 模板](https://www.overleaf.com/latex/templates/gui-zhou-da-xue-yan-jiu-sheng-bi-ye-lun-wen-mo-ban/tstnysppbxvh)。

### 更新历史
- **2.1.0** (2026-07-22) 承诺书自动排版、答辩委员会名单单独打印，重构盲审回复并新增答辩讲稿
    - 新增 `metadata.tex` 集中管理论文元数据，主论文与答辩委员会名单入口共用
    - 终稿封面后自动生成承诺书：使用 `logo/promise-normalized.pdf` 作为底图，支持签名图片叠加、日期和保密/不保密勾选
    - 新增 `defense_committee.tex` 入口与 `\makedefensepage` 命令，可单独打印答辩委员会名单
    - 新增 `\defensepdf` 命令，支持直接插入已签字的答辩委员会名单扫描件
    - 重构 `reviewresponse.cls`，正文语义命令移至 `reviewresponse-content.sty`，新增“修改概况”页
    - 新增 `defensespeech.cls` 答辩讲稿文档类

- **2.0.0** (2026-04-22) 按新版研究生学位论文写作格式通知调整
    - 根据贵州大学研究生院 2026 年 3 月 9 日发布的新版研究生学位论文写作格式通知调整
    - `windows` 参数显式启用 Windows 常用中文字体、华文行楷、Times New Roman 和 Arial 字体检查

- **1.1.4** (2026-04-22) 调整论文模板排版与校徽资源，添加盲审回复模版

- **1.1.3** (2026-03-13) 添加双面打印空白页水印，优化行间距

- **1.1.2** (2025-01-12) 调整字体搜索策略，以及其他优化
    - 增加模板参数 `tnra` 启用 Times New Roman, Arial 字体 系统需要有对应字体
    - 增加模板参数 `hwxk` 启用华文行楷字体，系统或当前目录需要有对应字体
    - 其他优化

- **1.1.1** (2024-08-19) 添加外部字体支持


- **1.1.0** (2024-08-18) 重构
    - 规避版权风险，删除了内置字体
    - 增加代码注释
    - 参考文献设置移除宏包
    
- **1.0.0** (2022-08-17) 初始版本
    - 间距格式调整
    - 内置华文行楷
    - 输出版本控制(完成部分)
    - 兼容Mac/Linux
    - 兼容 overleaf
    - 答辩委员会名单
    - 附录
    - 摘要关键字
    - 目录

### 使用
请参看 GZUthesis.tex 文件（模板使用手册）。论文元数据统一填写在 `metadata.tex` 中，各入口文件通过 `\input{metadata.tex}` 复用。

### 字体说明
模板默认由 `ctex` 选择中文字体。Windows 系统通常不需要开启 `windows` 选项；只有在非 Windows 系统已经安装 Windows 常用字体，或希望显式指定 SimSun/FangSong/SimHei/KaiTi 等字体时，才需要使用 `windows` 选项。

启用 `windows` 选项后，模板会依次查找系统字体名和当前目录字体文件：宋体 `SimSun`/`simsun.ttc`、仿宋 `FangSong`/`simfang.ttf`、黑体 `SimHei`/`simhei.ttf`、楷体 `KaiTi`/`simkai.ttf`。若仍未找到，则读取 `ctex/xeCJK` 已定义的默认字体族作为兜底：`zhsong`、`zhfs`、`zhhei`、`zhkai`。宋体族的中文斜体会使用楷体作为 `ItalicFont`，中文加粗使用伪粗。

### 编译
编译 说明文档（使用手册）
```bash
xelatex GZUthesis.tex
```

#### 使用 latexmk 编译
本项目可使用 `latexmk` 编译文档，文档及编译临时文件会保存在 `out` 目录下。
如果使用 TexStudio 应设置默认编译器为 `Latexmk`，并开启高级选项，在构建中将 `out` 添加到附加搜索路径中。

latexmk 配置文件为 `.latexmkrc`，默认编译主论文 `final_thesis.tex`。

命令行编译
```bash
latexmk                     # 主论文，输出 out/final_thesis.pdf
latexmk final_thesis.tex    # 显式编译主论文
latexmk defense_committee.tex  # 单独打印答辩委员会名单
latexmk response.tex        # 盲审意见回复
latexmk -c                  # 清理辅助文件，保留已生成的 PDF
```


## beamer 模板

在 beamer 目录下

## 盲审意见修改模版

见 `response.tex`，使用 `reviewresponse` 文档类（`\documentclass[degree=doctor|master]{reviewresponse}`），正文语义命令由 `reviewresponse-content.sty` 提供：

- `modificationoverview` 环境：正文之前的“修改概况”页，概述主要修改内容与涉及章节
- `\reviewcomment{...}`：逐条填写专家意见
- `\reviewresponse{...}`：对意见的回复
- `\reviewchange{...}`：论文中的具体修改位置和修改说明
- `changes` 环境：摘录修改后的论文原文，使用楷体缩进与回复正文区分

每个 `\section{盲审专家意见 N}` 对应一位专家，意见编号会在每个新 section 时自动重新计数。

编译：
```bash
latexmk response.tex
```

## 答辩讲稿模板

`defensespeech.cls` 提供答辩讲稿排版（双栏 A4，自动页眉页脚和“第 x 页，共 y 页”页码）。使用 `\title{论文题目}`、`\author{姓名}` 设置标题区信息。

```latex
\documentclass{defensespeech}
\title{论文题目}
\author{姓名}
\begin{document}
\makespeechtitle
\speechsection{开场}
\speechslide{1}{封面与背景介绍}
...讲稿正文...
\speechslide{2}{相关工作}
\speechspecial{结束页}
\end{document}
```

- `\makespeechtitle`：输出标题区
- `\speechsection{...}`：讲稿分节
- `\speechslide{Beamer页码}{页面标题}`：按 beamer 页码逐页撰写讲稿
- `\speechspecial{...}`：候场页、结束页等无正式 beamer 页码的页面
- `\pagenote{...}`：可选，在标题区追加说明文字
