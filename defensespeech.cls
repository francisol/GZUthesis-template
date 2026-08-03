\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{defensespeech}[2026/07/19 v1.1 Chinese defense speech handout]

\LoadClass[10pt,a4paper,twoside,twocolumn]{ctexart}

\RequirePackage{geometry}
\RequirePackage{xcolor}
\RequirePackage{hyperref}
\RequirePackage{fancyhdr}
\RequirePackage{needspace}
\RequirePackage{microtype}
\RequirePackage{lastpage}
\RequirePackage{flushend}

\geometry{
  inner=1.45cm,
  outer=1.25cm,
  top=1.35cm,
  bottom=1.35cm,
  columnsep=0.78cm,
  headheight=14pt,
  headsep=0.35cm,
  footskip=0.7cm
}

\definecolor{SpeechTitleColor}{RGB}{35,62,98}
\definecolor{SpeechSectionColor}{RGB}{70,70,70}

\hypersetup{hidelinks}
\setlength{\parindent}{2em}
\setlength{\parskip}{0.08em}
\linespread{1.04}
\raggedbottom
\emergencystretch=2em

% ---------- 文档元数据 ----------
% 沿用 LaTeX 标准接口：\title{论文题目}、\author{作者姓名}。
% 页面说明为可选项，默认不显示。
\title{请填写论文题目}
\author{请填写姓名}
\newcommand{\SpeechPageNote}{}
\newcommand{\pagenote}[1]{\renewcommand{\SpeechPageNote}{#1}}

% ---------- 页眉页脚 ----------
\makeatletter
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE]{\small\color{SpeechSectionColor}\@title}
\fancyhead[RO]{\small\color{SpeechSectionColor}博士学位论文答辩讲稿}
\fancyfoot[LE,RO]{\small 第\thepage 页，共\pageref{LastPage}页}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0pt}

% ---------- 标题区 ----------
\newcommand{\makespeechtitle}{%
  \twocolumn[
  \begin{center}
    {\LARGE\bfseries 博士学位论文答辩讲稿}\par
    \vspace{0.35em}
    {\large《\@title》}\par
    \vspace{0.35em}
    {\normalsize \@author}\par
    \ifx\SpeechPageNote\@empty
    \else
      \vspace{0.45em}
      {\small \SpeechPageNote}\par
    \fi
    \vspace{0.65em}
  \end{center}
  ]
}
\makeatother

% ---------- 章节和逐页讲稿 ----------
\newcommand{\speechsection}[1]{%
  \par\needspace{5\baselineskip}%
  \vspace{0.45em}%
  {\large\bfseries\color{SpeechSectionColor}#1}\par
  \vspace{0.15em}\hrule height 0.3pt\vspace{0.45em}%
}

% 用法：\speechslide{Beamer页码}{页面标题}
\newcommand{\speechslide}[2]{%
  \par\needspace{5\baselineskip}%
  \vspace{0.38em}%
  {\bfseries\color{SpeechTitleColor}#1页｜#2}\par
  \vspace{0.08em}%
}

% 用于无正式 Beamer 页码的候场页或结束页
\newcommand{\speechspecial}[1]{%
  \par\needspace{5\baselineskip}%
  \vspace{0.38em}%
  {\bfseries\color{SpeechTitleColor}#1}\par
  \vspace{0.08em}%
}
