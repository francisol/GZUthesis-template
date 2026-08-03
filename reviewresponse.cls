\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reviewresponse}[2026/07/18 Single-sided thesis review response class]

\newif\ifresponse@doctor
\newif\ifresponse@master
\response@doctortrue
\response@masterfalse

\DeclareOption{doctor}{\response@doctortrue\response@masterfalse}
\DeclareOption{master}{\response@doctorfalse\response@mastertrue}
\DeclareOption{degree=doctor}{\response@doctortrue\response@masterfalse}
\DeclareOption{degree=master}{\response@doctorfalse\response@mastertrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[11pt,a4paper,oneside]{article}

\RequirePackage[UTF8,scheme=plain]{ctex}
\RequirePackage{fontspec}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage[
  a4paper,
  top=2.45cm,
  bottom=2.45cm,
  left=3.00cm,
  right=2.50cm,
  footskip=1.05cm
]{geometry}
\RequirePackage[colorlinks=true,allcolors=black,pdfborder={0 0 0}]{hyperref}
\RequirePackage{indentfirst}
\RequirePackage{ifthen}
\RequirePackage{fancyhdr}
\RequirePackage{setspace}
\RequirePackage{titlesec}

\IfFontExistsTF{TeX Gyre Termes}{\setmainfont{TeX Gyre Termes}}{}
\IfFontExistsTF{Noto Serif CJK SC}{%
  \setCJKmainfont{Noto Serif CJK SC}[BoldFont=Noto Serif CJK SC Bold]
  \setCJKsansfont{Noto Sans CJK SC}[BoldFont=Noto Sans CJK SC Bold]
  \setCJKmonofont{Noto Sans Mono CJK SC}
}{}

\setstretch{1.36}
\setlength{\parindent}{2em}
\setlength{\parskip}{0.12em}
\setlength{\emergencystretch}{2em}
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000
\raggedbottom

% Section headings carry the expert grouping. They are unnumbered in print but
% remain regular \section entries and therefore appear in the contents.
\setcounter{secnumdepth}{0}
\setcounter{tocdepth}{1}
\titleformat{\section}{\zihao{4}\bfseries}{}{0pt}{}
\titlespacing*{\section}{0pt}{0pt}{1.25ex plus .2ex}

\def\response@university{贵州大学}
\def\response@title{}
\def\response@author{}
\def\response@stuid{}
\def\response@major{}
\def\response@research{}
\def\response@supervisor{}
\def\response@date{\number\year\ 年\ \number\month\ 月\ \number\day\ 日}

\newcommand{\university}[1]{\global\def\response@university{#1}}
\newcommand{\degree}[1]{%
  \ifthenelse{\equal{#1}{doctor}}{\global\response@doctortrue\global\response@masterfalse}{%
    \ifthenelse{\equal{#1}{master}}{\global\response@doctorfalse\global\response@mastertrue}{%
      \ClassError{reviewresponse}{degree error: #1}{Select doctor or master.}}}}
\newcommand{\stuid}[1]{\global\def\response@stuid{#1}}
\newcommand{\major}[1]{\global\def\response@major{#1}}
\newcommand{\research}[1]{\global\def\response@research{#1}}
\newcommand{\supervisor}[1]{\global\def\response@supervisor{#1}}
\renewcommand{\title}[1]{\global\def\response@title{#1}\hypersetup{pdftitle={#1}}}
\renewcommand{\author}[1]{\global\def\response@author{#1}}
\renewcommand{\date}[1]{\global\def\response@date{#1}}

\newcommand{\responsecoverdoctype}{%
  \ifresponse@doctor 博士\else\ifresponse@master 硕士\fi\fi 学位论文盲审意见回复}

\newcommand{\responsecoverrow}[2]{%
  \par\noindent
  \makebox[3.7cm][l]{\bfseries #1}\hspace{0.45cm}%
  \makebox[8.1cm][l]{#2}\par\vspace{0.55cm}}

\renewcommand{\maketitle}{%
  \begin{titlepage}
    \thispagestyle{empty}
    \centering
    \vspace*{1.9cm}
    {\zihao{2}\bfseries \response@university\par}
    \vspace{1.35cm}
    {\zihao{1}\bfseries \responsecoverdoctype\par}
    \vspace{1.25cm}
    {\zihao{2}\bfseries \response@title\par}
    \vfill
    \begin{minipage}{12.4cm}
      \zihao{4}
      \responsecoverrow{姓\hfill 名}{\response@author}
      \responsecoverrow{学\hfill 号}{\response@stuid}
      \responsecoverrow{学\hfill 科\hfill 专\hfill 业}{\response@major}
      \responsecoverrow{研\hfill 究\hfill 方\hfill 向}{\response@research}
      \responsecoverrow{导\hfill 师}{\response@supervisor}
    \end{minipage}
    \vfill
    {\zihao{4}\response@date\par}
    \vspace*{0.9cm}
  \end{titlepage}
}

\fancypagestyle{responsebody}{%
  \fancyhf{}
  \fancyfoot[C]{\small\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\makeatletter
\renewcommand{\tableofcontents}{%
  \clearpage
  \thispagestyle{empty}%
  \begingroup
    \centering
    \vspace*{0.8cm}
    {\zihao{3}\bfseries 目录\par}%
    \vspace{1.0cm}%
    \@starttoc{toc}%
  \endgroup
  \clearpage
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
  \pagestyle{responsebody}%
}
\makeatother
