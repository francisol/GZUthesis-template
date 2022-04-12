% 
% 贵州大学研究生学位论文模板
% 制作方: 贵州大学计算机科学与技术学院
% 作  者: 谢仲涛

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{GZUthesis}[2022/04/30 v0.1 GZUthesis]
\LoadClass[cs4size,a4paper,fancyhdr,fntef]{article}
\RequirePackage{ctex}
\RequirePackage{ifthen}
\RequirePackage{geometry}
\RequirePackage{hyperref}
\RequirePackage{etoolbox}
\RequirePackage[title,toc]{appendix}
\RequirePackage{setspace,titletoc,fancyhdr,pdfpages,caption}
\RequirePackage[backend = biber, style=biblatex/gb7714_2015]{biblatex}
\renewcommand{\appendixname}{附录}
\renewcommand{\appendixtocname}{附录}
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
\def\@secretary{}
\def\@expertlist{}
\def\@chairman{}
\def\@major{}
\def\@research{}
\def\@supervisor{}
\def\@stuid{}
\def\@title{}
\def\@author{}
\def\@enrollmentyear{}
\def\@defensedate{\today}
\def\@defenseaddress{中国}
\newcommand\major[1]{\def\@major{#1}} % 学科专业
\newcommand\research[1]{\def\@research{#1}} %研究方向
\newcommand\supervisor[1]{\def\@supervisor{#1}} % 导师
\newcommand\stuid[1]{\def\@stuid{#1}} % 学号
\renewcommand\title[1]{\def\@title{#1} \hypersetup{pdftitle={#1}}} %论文题目
\renewcommand\author[1]{\def\@author{#1} \hypersetup{pdfauthor={#1},pdfcreator={#1},pdfproducer={#1}}} % 作者
\newcommand{\enrollmentyear}[1]{\def\@enrollmentyear{#1}} %入学日期
\newcommand{\doctor}{\def\@isdoctor{1}} %指定博士格式
\newcommand{\address}[1][中国﹒贵州﹒贵阳]{\def\@address{#1}} % 指定地址
\newcommand{\secretary}[1]{\def\@secretary{#1}}
\newcommand{\defensedate}[1]{\def\@defensedate{#1}}
\newcommand{\defenseaddress}[1]{\def\@defenseaddress{#1}}
% 答辩专家
\newcommand{\expert}[1]{\listadd{\@expertlist}{#1}}
\newcommand{\chairman}[1]{\def\@chairman{#1}}
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
\newcommand{\defensemaintitlefont}{\heiti\fontsize{22pt}{\baselineskip}}
\newcommand{\defensetitlefont}{\heiti\fontsize{18pt}{\baselineskip}}
\newcommand{\defensecontentfont}{\heiti \zihao{-3}}


% 修改“目录”样式
\renewcommand*\contentsname{\centerline{目录} } 

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
\titlecontents{section}[0pt]{\addvspace{2pt}\filright}
{\contentspush{\thecontentslabel }\ }
{}{\titlerule*[8pt]{.}\contentspage}
\titlecontents{subsection}[2em]{\addvspace{2pt}\filright}
{\contentspush{\thecontentslabel }\ }
{20pt}{\titlerule*[8pt]{.}\contentspage}
\titlecontents{subsubsection}[4em]{\addvspace{2pt}\filright}
{\contentspush{\thecontentslabel }\ }
{20pt}{\titlerule*[8pt]{.}\contentspage}

\ctexset{bibname=\centering{参考文献}}
% 重定义摘要
\renewenvironment{abstract}[1][摘要]{%
\section*{\ }
\centerline{\abstractHeadFont \uppercase{#1}}
	\addcontentsline{toc}{section}{\uppercase{#1}}
	\songti\fontsize{12pt}{\baselineskip}
	\font\rm="Times New Roman" at 12pt \rm
	\selectfont
	\par
	\abstractContentFont
}{\newline}

\newcommand{\keywords}[1][关键词：]{
	\keywordsheadfont #1 %
	\keywordscontentfont
}

% 封面制作
\newcommand{\makecover}{
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
}
%  答辩名单
\newcommand{\makedefenselist}{
	~\\[37pt]
	\centerline{\defensemaintitlefont  \ifthenelse{\equal{\@isdoctor}{1}}{博}{硕}士学位论文答辩委员会名单}
	~\\[57pt]
	\centerline{\defensetitlefont \@title}
	~\\[55pt]
	% \begin{center}
	% 	\defensecontentfont\fbox{
	% 	答辩人:
	% }
	% \end{center}
	\renewcommand{\do}[1]{##1 \newline}%
	\par
	\begin{spacing}{1.65}
		\defensecontentfont \hangindent 10em \hangafter=0 \noindent
 答辩人： \@author \newline
	答辩委员会委员：\newline
	\@chairman \newline
	\dolistloop\@expertlist
	答辩秘书：\@secretary\newline
	答辩时间：\@defensedate\newline
	答辩地点：\@defenseaddress\newline
		\end{spacing}
		\thispagestyle{empty}
}

\renewcommand{\maketitle}{
	\makecover
	\newpage
	\makedefenselist
	\newpage
}
\renewcommand{\bibfont}{\setstretch{1} \zihao{5} \heiti \font\rm="SimSun" at 10.5pt \rm}
% 致谢
\newenvironment{thank}{
	% \begin{center}
		% \heiti \fontsize{15pt}{\baselineskip} \section*{致谢}
		\section*{\centerline{致谢}}
		\addcontentsline{toc}{section}{致谢}
	% \end{center}
}{}

\renewcommand{\captionfont}{\zihao{5} \heiti \font\rm="SimHei" at 10.5pt \rm }
\newcommand\page{
	\pagenumbering{Roman}
	% \pagestyle{fancy}
}
\newcommand\content{
	\pagenumbering{arabic}
	% \chead{
	% 	\begin{spacing}{0.5}
	% 		\fontsize{12pt}{\baselineskip}\heiti 贵州大学本科毕业论文（设计）
	% 	\end{spacing}
	% }
	% \lhead{\ \ \ \ \ \ \ \ \ \ \  \includegraphics[width=1.91cm]{figures/login.jpg}}
	% \rhead{
	% 	\begin{spacing}{0.5}
	% 		\fontsize{12pt}{\baselineskip} 第\ \ \thepage \ \ 页
	% 	\end{spacing}
	% }
	% \cfoot{}
	% \pagestyle{fancy}
}


\defbibheading{bibliography}[\bibname]{%
  \section*{\centering 参考文献}%
  \addcontentsline{toc}{section}{参考文献}
}

\newcommand{\promise}{\includepdf{figures/page.pdf}}
