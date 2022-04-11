% 
% 贵州大学研究生学位论文模板
% 制作方: 贵州大学计算机科学与技术学院
% 作  者: 谢仲涛

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{GZUthesis}[2022/04/30 v0.1 GZUthesis]
\LoadClass[cs4size,a4paper,fancyhdr,fntef]{book}
\RequirePackage{ctex}
\RequirePackage{ifthen}
\RequirePackage{geometry}
\RequirePackage{hyperref}
\RequirePackage[backend = biber, style=biblatex/gb7714_2015]{biblatex}
% \RequirePackage{setspace}
% \setstretch{1.2} 
\newcommand\dlmu[2][4cm]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
\geometry{a4paper,top=3cm,bottom=2.5cm,left=2.6cm,right=2.6cm}
\RequirePackage{fontspec}
\newfontfamily\arialf{Arial}
\setmainfont{Times New Roman}
% 变量定义
\def\@isdoctor{0} %是否是博士 默认为 否
\def\@address{中国﹒贵州﹒贵阳} % 地址
\newcommand\major[1]{\def\@major{#1}} % 学科专业
\newcommand\research[1]{\def\@research{#1}} %研究方向
\newcommand\supervisor[1]{\def\@supervisor{#1}} % 导师
\newcommand\stuid[1]{\def\@stuid{#1}} % 学号
\renewcommand\title[1]{\def\@title{#1} \hypersetup{pdftitle={#1}}} %论文题目
\renewcommand\author[1]{\def\@author{#1} \hypersetup{pdfauthor={#1},pdfcreator={#1},pdfproducer={#1}}} % 作者
\newcommand{\enrollmentyear}[1]{\def\@enrollmentyear{#1}} %入学日期
\newcommand{\doctor}{\def\@isdoctor{1}} %指定博士格式
\newcommand{\address}[1][中国﹒贵州﹒贵阳]{\def\@address{#1}} % 指定地址

% 格式定义 控制显示格式
\newcommand{\abstractHeadFont}{\zihao{-2}\arialf\heiti}
\newcommand{\abstractContentFont}{\songti \zihao{4}}
\newcommand{\keywordsheadfont}{\heiti \zihao{4}}
\newcommand{\keywordscontentfont}{\songti \zihao{4}}
\newcommand{\schoolnamefont}{\heiti \zihao{3}}
\newcommand{\facetitlefont}{\heiti \zihao{-3}}
\newcommand{\faceinfofont}{\songti \fontsize{10pt}{0pt}}
\newcommand{\maintitlefont}{\heiti \zihao{2}}
\newcommand{\addressfont}{\heiti \zihao{4}}
\newcommand{\datefont}{\heiti \zihao{4}}
\newcommand{\infodeatailfont}{\heiti\fontsize{16pt}{\baselineskip}}


\newenvironment{abstract}[1][摘要]{%
\centerline{\abstractHeadFont \uppercase{#1}}
    \par
	\abstractContentFont
}{\newline}

\newcommand{\keywords}[1][关键词：]{
	\keywordsheadfont #1 %
	\keywordscontentfont
}

\renewcommand{\maketitle}{
	\noindent  \faceinfofont 分\ \ 类\ \ 号：\dlmu[2cm]{} \hfill 密级：\dlmu[2cm]{} \newline
	\noindent\faceinfofont 论文编号：\dlmu[2cm]{\@stuid} \newline
	\\[42pt]
	\centerline{\schoolnamefont 贵\ \ \ \ 州\ \ \ \ 大\ \ \ \ 学}\newline
	\centerline{\facetitlefont \@enrollmentyear 届\ifthenelse{\equal{\@isdoctor}{1}}{博}{硕}士研究生学位论文}\newline
	\\[110pt]
	\centerline{\maintitlefont \@title}\newline
	\\[95pt]
	\begin{center}
		\infodeatailfont
		\textbf{学科专业：} \dlmu{\@major}\newline
		\textbf{研究方向：} \dlmu{\@research} \newline
		\textbf{导\ \ \ \ \ \ \ \ 师：} \dlmu{\@supervisor} \newline
		\textbf{研\ \ 究\ \ 生：} \dlmu{\@author}\newline
		\\[48.5pt]
	\end{center}
	\centerline{\addressfont \@address}
	\centerline{\datefont \@date}
	\thispagestyle{empty}
	\newpage
}
