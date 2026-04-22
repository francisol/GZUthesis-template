\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reviewresponse}[2026/04/22 Defense response document class]

\newif\ifresponse@doctor
\newif\ifresponse@master
\response@doctortrue
\response@masterfalse

\DeclareOption{doctor}{%
	\response@doctortrue
	\response@masterfalse
}
\DeclareOption{master}{%
	\response@doctorfalse
	\response@mastertrue
}
\DeclareOption{degree=doctor}{%
	\response@doctortrue
	\response@masterfalse
}
\DeclareOption{degree=master}{%
	\response@doctorfalse
	\response@mastertrue
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass{article}

\RequirePackage[UTF8]{ctex}
\RequirePackage{times}
\RequirePackage[T1]{fontenc}
\RequirePackage[a4paper,top=2.5cm,bottom=2cm,left=2.5cm,right=2.5cm]{geometry}
\RequirePackage[colorlinks=true,allcolors=black]{hyperref}
\RequirePackage{indentfirst}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\RequirePackage[skins,breakable]{tcolorbox}

\setlength{\parindent}{2em}
\setlength{\parskip}{0.25em}
\setlength{\emergencystretch}{2em}

\colorlet{commentbg}{black!5!white}
\colorlet{commenttitle}{black!60!white}
\colorlet{commentframe}{black!60!white}
\definecolor{colorchangebg}{gray}{0.96}
\definecolor{colorchangeframe}{gray}{0.45}
\colorlet{colorchangetext}{black}

\def\response@university{贵州大学}
\def\response@title{}
\def\response@author{}
\def\response@stuid{}
\def\response@major{}
\def\response@research{}
\def\response@supervisor{}
\def\response@date{\today}

\newcommand{\university}[1]{\global\def\response@university{#1}}
\newcommand{\degree}[1]{%
	\ifthenelse{\equal{#1}{doctor}}{%
		\global\response@doctortrue
		\global\response@masterfalse
	}{%
		\ifthenelse{\equal{#1}{master}}{%
			\global\response@doctorfalse
			\global\response@mastertrue
		}{%
			\ClassError{reviewresponse}{degree error: #1}{Select doctor or master.}%
		}%
	}%
}
\newcommand{\stuid}[1]{\global\def\response@stuid{#1}}
\newcommand{\major}[1]{\global\def\response@major{#1}}
\newcommand{\research}[1]{\global\def\response@research{#1}}
\newcommand{\supervisor}[1]{\global\def\response@supervisor{#1}}
\renewcommand{\title}[1]{%
	\global\def\response@title{#1}%
	\hypersetup{pdftitle={#1}}%
}
\renewcommand{\author}[1]{\global\def\response@author{#1}}
\renewcommand{\date}[1]{\global\def\response@date{#1}}

\newcommand{\responsecoverdoctype}{%
	\ifresponse@doctor 博士\else\ifresponse@master 硕士\fi\fi 学位论文盲审意见回复%
}

\newcommand{\responsecoverrow}[2]{%
	\par\noindent
	\makebox[3.3cm][l]{\bfseries #1}%
	\hspace{0.8cm}%
	\makebox[8.5cm][l]{#2}%
	\par\vspace{0.65cm}%
}

\renewcommand{\maketitle}{%
	\begin{titlepage}
		\thispagestyle{empty}
		\centering
		\vspace*{2.0cm}
		{\zihao{2}\bfseries \response@university\par}
		\vspace{1.0cm}
		{\zihao{1}\bfseries \responsecoverdoctype\par}
		\vspace{0.9cm}
		\rule{0.72\textwidth}{0.5pt}\par
		\vspace{0.85cm}
		{\zihao{2}\bfseries \response@title\par}
		\vspace{0.85cm}
		\rule{0.72\textwidth}{0.5pt}\par
		\vfill
		\begin{center}
      ~\vspace{1cm}
		\begin{minipage}{12.6cm}
			\raggedright\zihao{4}
			\responsecoverrow{姓\hfill 名}{\response@author}
			\responsecoverrow{学\hfill 号}{\response@stuid}
			\responsecoverrow{学\hfill 科\hfill 专\hfill 业}{\response@major}
			\responsecoverrow{研\hfill 究\hfill 方\hfill 向}{\response@research}
			\responsecoverrow{导\hfill 师}{\response@supervisor}
		\end{minipage}
		\end{center}
		\vfill
		{\zihao{4}\response@date\par}
		\vspace*{1.0cm}
	\end{titlepage}
	\clearpage
}

\renewcommand{\tableofcontents}{%
	\clearpage
	\thispagestyle{empty}%
	\begingroup
	\renewcommand*\l@section{\@dottedtocline{1}{0em}{1.8em}}%
	\centering{\zihao{3}\bfseries 目录\par}%
	\vspace{1.2cm}%
	\@starttoc{toc}%
	\endgroup
	\thispagestyle{empty}%
	\clearpage
	\pagenumbering{arabic}%
	\setcounter{page}{1}%
}

\newcounter{reviewer}
\newcounter{reviewcomment}[reviewer]

\newcommand{\reviewersection}[1]{%
	\refstepcounter{reviewer}%
	\ifnum\value{reviewer}>1\clearpage\fi
	\setcounter{reviewcomment}{0}%
	\phantomsection
	\addcontentsline{toc}{section}{#1}%
	\section*{#1}%
}

\newenvironment{revcomment}[1][]{%
	\refstepcounter{reviewcomment}%
	\begin{tcolorbox}[
		enhanced jigsaw,
		breakable,
		adjusted title = {意见 \arabic{reviewcomment}},
		fonttitle = \bfseries,
		colbacktitle = commenttitle,
		coltitle = white,
		colback = commentbg,
		colframe = commentframe,
		boxrule = 0pt,
		arc = 0pt,
		left = 1.5mm,
		right = 1.5mm,
		top = 1mm,
		bottom = 1mm,
		before skip = 0.45cm,
		after skip = 0.12cm,
		#1
	]%
}{%
	\end{tcolorbox}%
}

\newenvironment{revresponse}
	{\par\vspace{0.08cm}\noindent\textbf{回复 \arabic{reviewcomment}：}\par\vspace{0.08cm}\noindent}
	{\par\vspace{0.35cm}}

\newenvironment{changes}{%
	\begin{tcolorbox}[
		breakable,
		left skip = 0em,
		enhanced jigsaw,
		colback = {colorchangebg},
		colframe = {colorchangeframe},
		boxrule = 0.4pt,
		leftrule = 2pt,
		opacityback = 1,
		opacityframe = 1,
		arc = 0pt,
		left = 1.5mm,
		right = 1.5mm,
		top = 1mm,
		bottom = 1mm,
		before skip = 0.18cm,
		after skip = 0.25cm
	]\color{colorchangetext}%
	\setlength{\parindent}{2em}%
}{%
	\end{tcolorbox}%
}
