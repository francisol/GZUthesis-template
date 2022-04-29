# 贵州大学研究生学位论文模板
制作方: 贵州大学计算机科学与技术学院


![format](img/format.png)
## Task
- [ ] 间距格式调整
- [ ] 输出版本控制(完成部分)
- [X] 答辩委员会名单
- [X] 附录 
- [x] 摘要关键字
- [X] 目录

## 未来计划
### 格式调整
对行间距进行复刻
### 版本控制
通过不同命令输出 不同版本的论文格式：
-  \printversion    打印版本
- \evaluateversion 送审版本(盲审)
- \submitversion   提交版本
- \draftversion    草稿版本
## 使用
默认是硕士版本使用 `\isdoctor` 命令切换博士版本。

日期需使用中文分割如`\date{20XX年XX月}` 或者 `\date{20XX年XX月XX日}`
### 版本控制
```latex
\def\evaluateversion{} %输出盲审版本
\def\printversion{}   % 输出打印版本
```