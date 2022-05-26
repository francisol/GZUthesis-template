% 
% 贵州大学研究生学位论文模板
% 制作方: 贵州大学计算机科学与技术学院
% 作  者: XXX
% \printversion    打印版本
% \evaluateversion 送审版本
% \submitversion   提交版本
% \draftversion    草稿版本
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{GZUthesis}[2022/04/30 v0.1 GZUthesis]
\RequirePackage{xkeyval}
\RequirePackage{ifthen}

\define@choicekey*+{GZUthesis}{type}[\val\position]{doctor,master,bachelor}[master]{%
  \def\@type{#1}
  \ifcase\position\relax
  \def\@degree{博}
  \or%
  \def\@degree{硕}
  \or
  \def\@degree{学}
  \fi
}{%
  \ClassError{GZUthesis}{Neplatná hodnota argumentu lang: #1}
}
\ProcessOptionsX<GZUthesis>
\PassOptionsToClass{\CurrentOption}{article}
\LoadClass[cs4size,a4paper,fancyhdr,fntef]{article}
\RequirePackage[UTF8,zihao=-4,heading=true]{ctex}



\RequirePackage{geometry}
\RequirePackage{hyperref}
\RequirePackage{etoolbox}
\RequirePackage[title,toc]{appendix}
\RequirePackage{setspace,titletoc,fancyhdr,pdfpages,caption,ulem}
\RequirePackage[backend = biber, style=biblatex/gb7714_2015]{biblatex}

\newcommand\dlmu[2][4cm]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}}
\newcommand\dlwave[2][4cm]{\hskip1pt\uwave{\hb@xt@ #1{\hss#2\hss}}}
\geometry{a4paper,top=2.9cm,bottom=2.4cm,left=2.5cm,right=2.5cm}
\RequirePackage{fontspec}
\setmainfont{Times New Roman}

\setCJKfamilyfont{hwxk}{STXingkai}
% 变量定义
\def\addrsep{ {\zihao{-1}{﹒} }}
\def\@address{中国\addrsep 贵州\addrsep 贵阳} % 地址
\def\@secretary{}
\def\@expertlist{}
\def\@chairman{}
\def\@major{}
\def\@research{}
\def\@supervisor{}
\def\@stuid{}
\def\@title{}
\def\@author{}
\def\@graduationyear{}
\edef\@defensedate{\today}
\edef\@date{\today}
\edef\@type{master}
\def\@defenseaddress{中国}
\edef\@degree{硕}
%% 定义控制变量
\def\@multititlewidth{14cm} %题目宽度
\def\@multititleheight{4.5em} %题目最多三行


%% 打印版日期格式
\def\parseprintdate#1年#2月#3\endparse{%
%   \date{\formatdate{#3}{#2}{#1}}%
%\zhdigits{#1}年 \zhdigits{#2}月
#1 年 #2 月
}
%% 送审版日期格式
\def\parseevaluatedate#1年#2月#3\endparse{%
% \zhdigits{#1}年 \uwave{\hskip3pt \zhdigits{#2}\hskip3pt }月%
#1年 \uwave{\hskip3pt #2 \hskip3pt }月%
}
\newcommand\major[1]{\def\@major{#1}} % 学科专业
\newcommand\research[1]{\def\@research{#1}} %研究方向
\newcommand\supervisor[1]{\def\@supervisor{#1}} % 导师
\newcommand\stuid[1]{\def\@stuid{#1}} % 学号
\renewcommand\title[1]{\def\@title{#1} \hypersetup{pdftitle={#1}}} %论文题目
\renewcommand\author[1]{\def\@author{#1} \hypersetup{pdfauthor={#1},pdfcreator={#1},pdfproducer={#1}}}% 作者
\newcommand{\graduationyear}[1]{\def\@graduationyear{#1}\hypersetup{pdfsubject={#1 届\@degree 士研究生学位论文}}} %毕业年份
\newcommand{\address}[1][中国\addrsep 贵州\addrsep 贵阳]{\def\@address{#1}} % 指定地址
\newcommand{\secretary}[1]{\def\@secretary{#1}}
\newcommand{\defensedate}[1]{\def\@defensedate{#1}}
\newcommand{\defenseaddress}[1]{\def\@defenseaddress{#1}}
% 答辩专家
\newcommand{\expert}[1]{\listadd{\@expertlist}{#1}}
\newcommand{\chairman}[1]{\def\@chairman{#1}}
% 格式定义 控制显示格式
\newcommand{\abstractheadfont}{\zihao{-2}\heiti \font\rm="Arial" at 18pt \rm\selectfont} %摘要标题字体
\newcommand{\abstractcontentfont}{\songti \zihao{4} \font\rm="Times New Roman" at 12pt \rm\selectfont} % 摘要内容字体
\newcommand{\keywordsheadfont}{\heiti \zihao{4}}
\newcommand{\keywordscontentfont}{\songti \zihao{4}}
\newcommand{\schoolnamefont}{\heiti \zihao{3}}
\newcommand{\facetitlefont}{\heiti \zihao{-3}}
\newcommand{\faceinfofont}{\songti \zihao{5}}
\newcommand{\maintitlefont}{\heiti \zihao{2}}
\newcommand{\addressfont}{\heiti \zihao{4}}
\newcommand{\datefont}{\heiti \zihao{4}}
\newcommand{\infodeatailfont}{\heiti\zihao{-3}}
\newcommand{\defensemaintitlefont}{\heiti\fontsize{22pt}{\baselineskip}}
\newcommand{\defensetitlefont}{\heiti\fontsize{18pt}{\baselineskip}}
\newcommand{\defensecontentfont}{\heiti \zihao{-3}}

%%% 盲审版本
% 华文行楷 初号
\newcommand{\evaluatenamefont}{\zihao{-0} \font\rm="STXingkai" at 36pt \rm
\CJKfamily{hwxk}}
\newcommand{\evaluatetitlefont}{\zihao{1} \font\rm="SimHei" at 26pt \rm
\heiti}

\newcommand{\evaluatetablefont}{\heiti \zihao{3} \font\rm="SimHei" at 16pt \rm}
\newcommand{\evaluateaddressfont}{\heiti \zihao{4} }
\newcommand{\evaluatedatefont}{\heiti \zihao{4}}


\renewcommand{\appendixname}{附录}
\renewcommand{\appendixtocname}{附录}
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
\centerline{\abstractheadfont \uppercase{#1}}
	\addcontentsline{toc}{section}{\uppercase{#1}}
	\par
	\abstractcontentfont
}{}

\newcommand{\keywords}[1][关键词：]{
	\par \noindent \keywordsheadfont #1 %
	\keywordscontentfont
}



% 封面制作 参数为下划线长度
\newcommand{\makecover}[1][6cm]{
	{
		\vspace{10em}
		\setstretch{0.1}
		~\\[0.1pt]
		%
		\setstretch{0.85}
		\noindent  \faceinfofont  分\ \ 类\ \ 号：\dlmu[2cm]{} \hfill 密级：\dlmu[2cm]{} \newline
		\noindent\faceinfofont 论文编号：\dlmu[2cm]{\@stuid} \newline
	
	}
	~\\[43.2pt]
	\centerline{\schoolnamefont 贵\ \ \ \ 州\ \ \ \ 大\ \ \ \ 学}\\[2.5pt]
	\centerline{\facetitlefont \@graduationyear 届\@degree 士研究生学位论文}\newline
	\\[90pt]
	\begin{center}
		\maintitlefont	
		\begin{minipage}[c][\@multititleheight][t]{\@multititlewidth}
			\begin{center}
				\@title
			\end{center}
		\end{minipage}
	\end{center}
	~\\[5pt]
	\begin{center}
		\setstretch{1.055}
		\infodeatailfont
		\textbf{学科专业：} \dlmu[#1]{\@major}\\[0pt]
		\textbf{研究方向：} \dlmu[#1]{\@research} \\
		\textbf{导\ \ \ \ \ \ \ \ 师：} \dlmu[#1]{\@supervisor} \\
		\textbf{研\ \ 究\ \ 生：} \dlmu[#1]{\@author}\\[70pt]
	\end{center}
	\begin{center}
		\setstretch{1.6}
		\addressfont \@address\\
		\datefont
		\expandafter\parseprintdate\@date\endparse


	\end{center}
	\thispagestyle{empty}
}
%  答辩名单
\newcommand{\makedefenselist}{
	~\\[25pt]
	\centerline{\defensemaintitlefont \@degree 士学位论文答辩委员会名单}
	~\\[32pt]
	\begin{center}
		\defensetitlefont	
		\begin{minipage}[t][\@multititleheight][t]{\@multititlewidth}
			\begin{center}
				\@title
			\end{center}
		\end{minipage}
	\end{center}
	~\\[30pt]
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

\newcommand{\makeevaluatecover}{
	\newgeometry{top=2.18cm,left=2.6cm,right=2.6cm}
	\setlength{\fboxsep}{20.5pt}\framebox[1\width][c]{论文编号：\dlmu[4.3cm]{}\hskip5pt}
	~\\[33pt]
	% 
	\begin{center}
		\includegraphics[width=3.05cm,height=3.0cm]{figures/gzu.jpg}\\
		\includegraphics[width=4.18cm,height=1.64cm]{figures/gzdx.png}		
	\end{center}
	\setstretch{1.0}
	\begin{center}
		\ziju{0.060}
		\evaluatenamefont{ \@graduationyear 届\@degree 士学位论文}
	\end{center}
	~\\[16.8pt]
	\begin{center}
		\evaluatetitlefont	
		\begin{minipage}[c][4ex][t]{\@multititlewidth}
			\begin{center}
				\@title 
			\end{center}
		\end{minipage}
	\end{center}
	~\\
	\begin{center}
		\setstretch{1.6}
		\evaluatetablefont 学科专业：\dlwave{\@major}\\
		研究方向：\dlwave{\@research}\\
	\end{center}
	~\\[53pt]
	\begin{center}
		
		\setstretch{1.6}
		\evaluateaddressfont{\@address}\\
		\evaluatedatefont \expandafter\parseevaluatedate\@date\endparse


	\end{center}

	\thispagestyle{empty}
	\newpage
	\restoregeometry
}
\renewcommand{\maketitle}{
	\ifthenelse{\isundefined{\evaluateversion}}{}{
		\makeevaluatecover
	}
	\ifthenelse{\isundefined{\printversion}}{}{
		\makecover
		\newpage
		\makedefenselist
		\newpage
	}
% \hypersetup{
%     pdftitle={\@title},
%     pdfauthor={\@author},

% }
	
}
\renewcommand{\bibfont}{\setstretch{1} \zihao{5} \heiti \font\rm="SimSun" at 10.5pt \rm}
% 致谢
\newenvironment{thank}{
		
		\section*{\centerline{致谢}}
		\addcontentsline{toc}{section}{致谢}
		\markboth{致谢}{致谢}
}{}

\renewcommand{\captionfont}{\zihao{5} \heiti \font\rm="SimHei" at 10.5pt \rm }



\defbibheading{bibliography}[\bibname]{%
  \section*{\centering 参考文献}%
  \addcontentsline{toc}{section}{参考文献}
  \markboth{参考文献}{参考文献}
}

\newcommand{\promise}{
	\ifthenelse{\isundefined{\printversion}}{}{
		\includepdf{figures/page.pdf}
	}
}
\AddToHook{cmd/section/before}{\clearpage}
\fancypagestyle{mainFancy}{
    \fancyhf{}
    \renewcommand\headrulewidth{0.5pt}
    \renewcommand\footrulewidth{0pt}
	\pagenumbering{arabic}
	\fancyhead[L]{\leftmark}
	\fancyhead[R]{\protect\nouppercase\@title}
    \fancyfoot[C]{\thepage}
}
\fancypagestyle{preContent}{
    \fancyhf{}
    \renewcommand\headrulewidth{0pt}
    \renewcommand\footrulewidth{0pt}
	\pagenumbering{roman}
    \fancyfoot[C]{\thepage}
}
\newcommand\frontmatter{
	\clearpage
	\pagestyle{preContent}
}
\newcommand\mainmatter{
	\clearpage
	\pagestyle{mainFancy}
}
\ctexset{
	section={
		name={第,章},
		number={\chinese{section}}
	},
	appendix={
		name={附录},
	}
}
\renewenvironment{appendices}{
	\appendix\addappheadtotoc
}{}
\hypersetup{
		bookmarks=true,         % show bookmarks bar?
	unicode=false,          % non-Latin characters in Acrobat’s bookmarks
	pdftoolbar=true,        % show Acrobat’s toolbar?
	pdfmenubar=true,        % show Acrobat’s menu?
	pdffitwindow=false,     % window fit to page when opened
	pdfstartview={FitH},
	colorlinks=true,
	linkcolor=black,citecolor=black,urlcolor=black}
