# 贵州大学研究生学位论文模板

贵州大学研究生学位论文模板, 随仓附赠 答辩beamer


## 论文模板
基于 book 制作，使用 xelatex 编译，本模板在Overleaf上同步更新：[Overleaf 模板](https://www.overleaf.com/latex/templates/gui-zhou-da-xue-yan-jiu-sheng-bi-ye-lun-wen-mo-ban/tstnysppbxvh)。

### 更新历史
- **1.1.3** (2026-03-13) 添加双面打印空白页水印，优化行间距

- **1.1.2** (2025-01-12) 调整字体搜索策略，以及其他优化
    - 增加模板参数 `tnra` 启用 Times New Roman, Arial 字体 系统需要有对应字体
    - 增加模板参数 `hwxk` 启用 华文楷体字体，系统或当前目录需要有对应字体
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
请参看 GZUthesis.tex 文件

### 编译
编译 说明文档
```bash
xelatex GZUthesis.tex
```
编译示例文档
```bash
xelatex final_thesis.tex
```
#### 使用 latexmk 编译
本项目可使用 `latexmk` 编译文档，文档及编译临时文件会保存在 `out` 目录下。
如果使用TexStudio应设置默认编译器为`Latexmk`， 并开启高级选项，在构建中将`out`添加到附加搜索路径中。

latexmk 配置文件为 `.latexmkrc`。

命令行编译
```bash
latexmk final_thesis.tex
```



## beamer 模板

在 beamer 目录下
