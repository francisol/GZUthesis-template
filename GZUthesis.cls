% 
% 贵州大学研究生学位论文模板
% 制作方: 贵州大学人工智能研究院
% 作  者: 谢仲涛

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{GZUthesis}[2022/04/30 v0.1 GZUthesis]

\LoadClass[cs4size,a4paper,fancyhdr,fntef]{book}
\RequirePackage{ctex}
\RequirePackage{ifthen}
\RequirePackage{geometry}
\newcommand\dlmu[2][4cm]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
\geometry{a4paper,top=3cm,bottom=2.5cm,left=2.6cm,right=2.6cm}
\RequirePackage{fontspec}
\newfontfamily\arialf{Arial}
\setmainfont{Times New Roman}
\newcommand\college[1]{\def\@college{#1}}
\newcommand\major[1]{\def\@major{#1}}
\newcommand\class[1]{\def\@class{#1}}
\newcommand\no[1]{\def\@no{#1}}
\newcommand\tutor[1]{\def\@tutor{#1}}
\newcommand\etitle[1]{\def\@etitle{#1}}
\renewcommand\title[1]{\def\@title{#1} \hypersetup{pdftitle={#1}}}
\renewcommand\author[1]{\def\@author{#1} \hypersetup{pdfauthor={#1},pdfcreator={#1},pdfproducer={#1}}}
\newenvironment{abstract}[1][zh]{%
    \ifthenelse{\equal{#1}{zh}}
    {\centerline{ \heiti \zihao{-2}摘要} \songti \zihao{4}}
    {\centerline{ \zihao{-2}\arialf ABSTRACT} \songti \zihao{4}}
    \par
}{\newline}

\newcommand{\keywords}[1][zh]{
    \ifthenelse{\equal{#1}{zh}}
    {\heiti \zihao{4}关键词：}
    {\zihao{4}key words:}%
}

\renewcommand{\maketitle}{
	\begin{center}
		\heiti
		\fontsize{16pt}{\baselineskip}
		\textbf{学\ \ \ \ \ \ 院：} \dlmu \@date \newline
		\textbf{专\ \ \ \ \ \ 业：} \dlmu dasda\newline
		\textbf{班\ \ \ \ \ \ 级：} \dlmu dasdas\newline
		\textbf{学\ \ \ \ \ \ 号：} \dlmu dasdsa\newline
		\textbf{学生姓名：} \dlmu dsda\newline
		\textbf{指导教师：} \dlmu dadas \newline
		\newline\newline\newline
		\songti \@date
	\end{center}
	\newpage
}
