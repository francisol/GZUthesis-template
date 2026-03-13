% ----------------------------------------------------------------
% GZUthesis.cls
% 贵州大学学位论文模板
% 
% Copyright (c) 2023-2025  https://github.com/francisol
% 
% 传播请注明来源，尊重作者劳动
% ----------------------------------------------------------------

% 声明文档类
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesPackage{GZUthesis}[2024/08/18 v1.1.3 Guizhou University Thesis Template]
\LoadClass[cs4size,a4paper,fancyhdr,fntef,oneside]{book}
\RequirePackage{xkeyval}
\RequirePackage{ifthen}
\RequirePackage{ifplatform}
\RequirePackage[intoc]{nomencl}
\RequirePackage{pgfkeys}

\def\GZU@university{贵州大学}
%
\def\GZU@review@topic{} % 盲审主题
\def\GZU@final@topic{} % 最终版主题
\def\GZU@defense@topic{士学位论文答辩委员会名单} % 答辩信息主题



%% 保存选项、命令设置的参数信息
\def\GZU@option@print{draft} % 打印类型
\def\GZU@option@degree{doctor} %学位信息
\def\GZU@paperno{} % 论文号
\def\GZU@seclvl{} %密级
\def\GZU@experts{} % 专家列表
\def\GZU@chairman{} % 答辩主席
\def\GZU@major{} % 学科专业
\def\GZU@class{} % 班级
\def\GZU@college{} % 学院
\def\GZU@research{} %研究方向
\def\GZU@supervisor{} % 导师
\def\GZU@stuid{} % 学号
\def\GZU@title{} % 论文题目
\def\GZU@author{} % 作者
\def\GZU@defaddr{} %答辩地点
\def\GZU@gradyear{\the\year} % 毕业年份
\def\GZU@defdate{\today} % 答辩时间
\def\GZU@date{\today} % 日期
\def\GZU@defsec{} %答辩秘书
\def\GZU@classifyno{} % 分类号

%% 根据其他信息生成的变量
\def\GZU@date@year{ \the\year}
\def\GZU@date@month{ \the\month}
\def\GZU@titlewidth{14cm} %题目宽度
\def\GZU@titleheight{3em} %题目最多两行

\def\GZU@fontname@song{}
\def\GZU@fontname@kai{}
\def\GZU@fontname@hei{}
\def\GZU@fontname@fsong{}
\def\parsedate#1年#2月#3\endparse{%
	\def\GZU@date@year{#1}
	\def\GZU@date@month{#2}
}

%% 常量
\def\GZU@table@major{学科专业}
\def\GZU@table@research{研究方向}
\def\GZU@table@supervisor{导师}
\def\GZU@table@author{研究生}
\def\GZU@table@classfyno{分类号}
\def\GZU@table@paperno{论文编号}
\def\GZU@table@seclvl{密级}
\def\GZU@defense@respondent{答辩人}
\def\GZU@defense@committee{答辩委员会委员}
\def\GZU@defense@secretary{答辩秘书}
\def\GZU@defense@date{答辩日期}
\def\GZU@defense@address{答辩地点}
\def\GZU@addrsep{ {\zihao{-1}{·} }}
\def\GZU@tablesep{：}
\def\GZU@address{中国\GZU@addrsep 贵州\GZU@addrsep 贵阳} % 地址不修改

%% if 判断
\newif\ifdoctor
\newif\ifmaster
\newif\ifbachelor
\newif\ifreview
\newif\iffinal
\newif\ifdraft
\newif\ifgrad %判断是否时研究生
\newif\iffullfont
\newif\ifchecktnra
\newif\ifcheckhwxk
\newif\ifenablewatermark %是否使用水印
\doctortrue
\drafttrue
\gradtrue
\checktnrafalse
\checkhwxkfalse
\enablewatermarkfalse

%%% 定义文档选项 %%%
% 定义学位类型 本硕博
\define@choicekey*+{GZUthesis}{degree}[\val\position]{doctor,master,bachelor}[doctor]{%
	%    \def\GZU@option@degree{#1}
	\ifcase\position\relax
		\doctortrue
		\masterfalse
		\bachelorfalse
		\gradtrue
	\or
		\doctorfalse
		\mastertrue
		\bachelorfalse
		\gradtrue
	\or
		\doctorfalse
		\masterfalse
		\bachelortrue
		\gradfalse
	\fi
}{%
	\ClassError{GZUthesis}{degree error: #1;select in doctor,master,bachelor }
}
% 定义打印类型 盲审 终稿 草稿
\define@choicekey*+{GZUthesis}{print}[\val\position]{draft,review,final}[draft]{%
	\global\def\GZU@option@print{#1}
	\ifcase\position\relax
		\reviewfalse
		\finalfalse
		\drafttrue
	\or
		\reviewtrue
		\finalfalse
		\draftfalse
	\or
		\reviewfalse
		\finaltrue
		\draftfalse
	\fi
}{%
	\ClassError{GZUthesis}{print error: #1;review,final,draft }
}
\DeclareOption{windows}{\fullfonttrue}
\DeclareOption{tnra}{\checktnratrue}
\DeclareOption{hwxk}{\checkhwxktrue}
\DeclareOption{watermark}{\enablewatermarktrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptionsX<GZUthesis>\relax


\RequirePackage{fontspec}

\RequirePackage[UTF8,zihao=-4,heading=true]{ctex}



% 加载第三方宏包

% \RequirePackage{titlesec}
% \RequirePackage{tocloft}
\RequirePackage{geometry}
\RequirePackage{hyperref}
% \RequirePackage{etoolbox}
\RequirePackage[title,toc]{appendix}
\RequirePackage{setspace,titletoc,fancyhdr,pdfpages,ulem}

% \RequirePackage{caption}
\RequirePackage{bicaption}


%%%  定义外部可用命令 %%%
%% 论文号
\newcommand{\paperno}[1]{\global\def\GZU@paperno{#1}}
%% 答辩秘书
\newcommand{\defsec}[1]{\global\def\GZU@defsec{#1}}
%% 添加答辩专家
\newcommand{\addexpert}[1]{\listadd{\GZU@experts}{#1}}
%% 答辩主席
\newcommand{\chairman}[1]{\global\def\GZU@chairman{#1}}
%% 学科专业
\newcommand{\major}[1]{\global\def\GZU@major{#1}}
%% 班级
\newcommand{\class}[1]{\global\def\GZU@class{#1}}
%% 学院
\newcommand{\college}[1]{\global\def\GZU@college{#1}}
%% 研究方向
\newcommand{\research}[1]{\global\def\GZU@research{#1}}
%% 导师
\newcommand{\supervisor}[1]{\global\def\GZU@supervisor{#1}}
%% 学号
\newcommand{\stuid}[1]{\global\def\GZU@stuid{#1}}
%% 论文题目
\renewcommand{\title}[1]{\global\def\GZU@title{#1} \hypersetup{pdftitle={#1}}}
%% 作者
\renewcommand{\author}[1]{\global\def\GZU@author{#1}}
%% 答辩地点
\newcommand{\defaddr}[1]{\global\def\GZU@defaddr{#1}}
%% 毕业年份
\newcommand{\gradyear}[1]{\global\def\GZU@gradyear{#1}}
%% 答辩时间
\newcommand{\defdate}[1]{\global\def\GZU@defdate{#1}}
%% 日期
\renewcommand{\date}[1]{\global\def\GZU@date{#1}}
%% 密级
\newcommand{\seclvl}[1]{\global\def\GZU@seclvl{#1}}
%% 分类号
\newcommand{\classifyno}[1]{\global\def\GZU@classifyno{#1}}


%%%%%%%%%%%%%%%%%%%%%%%% 处理字体 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%% 主题字体 默认楷体
\newcommand{\GZU@font@review@topic}{\zihao{-0} \CJKfamily+{zhkai}}

%% 字体检查，主要检查 华文楷体

\newcommand{\GZU@hwxkcheck}{
\ifwindows
    \def\xingkainame{STXINGKA}
\else
    \def\xingkainame{STXingkai}
\fi
	%% 主题字体，如果系统存在华文行楷则使用，如果没有则使用楷书
	\IfFontExistsTF{\xingkainame}{
		\setCJKfamilyfont{hwxk}{\xingkainame}
		\renewcommand{\GZU@font@review@topic}{\zihao{-0} \CJKfamily+{hwxk}}
	}{
		\IfFontExistsTF{STXINGKA.TTF}{
			\setCJKfamilyfont{hwxk}{STXINGKA.TTF}
			\renewcommand{\GZU@font@review@topic}{\zihao{-0} \CJKfamily+{hwxk}}
		}{
		}
	}

}

%% 字体检查，主要检查 Times New Roman, Arial
\newcommand{\GZU@tnracheck}{

	%% 如有Times New Roman，将其作为默认字体
	\IfFontExistsTF{Times New Roman}{
		\setmainfont{Times New Roman}
	}{
	}
	%% 如有Arial，将其作为无衬线字体
	\IfFontExistsTF{Arial}{
		\setsansfont{Arial}
	}{
	}
}



\newcommand{\GZU@usewindowsfont}{
	\IfFontExistsTF{SimSun}{
		\global\def\GZU@fontname@song{SimSun}
	}{
		\IfFontExistsTF{simsun.ttc}{
			\global\def\GZU@fontname@song{simsun.ttc}
		}{
			\fullfontfalse
		}
	}
	\IfFontExistsTF{FangSong}{
		\global\def\GZU@fontname@fsong{FangSong}
	}{

		\IfFontExistsTF{simfang.ttf}{
			\global\def\GZU@fontname@fsong{simfang.ttf}
		}{
			\fullfontfalse
		}
	}

	\IfFontExistsTF{SimHei}{
		\global\def\GZU@fontname@hei{SimHei}
	}{

		\IfFontExistsTF{simhei.ttf}{
			\global\def\GZU@fontname@hei{simhei.ttf}
		}{

			\fullfontfalse
		}
	}

	\IfFontExistsTF{KaiTi}{
		\global\def\GZU@fontname@kai{KaiTi}
	}{
		\IfFontExistsTF{simkai.ttf}{
			\global\def\GZU@fontname@kai{simkai.ttf}
		}{

			\fullfontfalse
		}
	}
	\iffullfont
		\setCJKmainfont[BoldFont=\GZU@fontname@hei,ItalicFont=\GZU@fontname@kai]{\GZU@fontname@song}
		\setCJKmonofont{\GZU@fontname@fsong}
		\setCJKfamilyfont{zhsong}{\GZU@fontname@song}
		\setCJKfamilyfont{zhhei}{\GZU@fontname@hei}
		\setCJKfamilyfont{zhfs}{\GZU@fontname@fsong}
		\setCJKfamilyfont {zhkai} {\GZU@fontname@kai}
	\fi
}

\ifwindows\GZU@hwxkcheck\GZU@ntracheck\else\iffullfont
		\GZU@usewindowsfont
	\fi\fi
\ifchecktnra\GZU@tnracheck\fi
\ifcheckhwxk\GZU@hwxkcheck\fi

\ifenablewatermark
  \RequirePackage[final]{draftwatermark}
  \RequirePackage{xcolor}
  \RequirePackage{graphicx}

  % ----------------------------
  %  水印控制参数
  % ----------------------------
  \newcommand{\GZU@blankpagespace}{1.5em}
  \newcommand{\GZU@blankpagetext}{%
  此\hspace{\GZU@blankpagespace}%
  页\hspace{\GZU@blankpagespace}%
  无\hspace{\GZU@blankpagespace}%
  正\hspace{\GZU@blankpagespace}%
  文%
}
  \newcommand{\GZU@blankpagefontsize}{36} % 字号（pt）
  \newcommand{\GZU@blankpageangle}{45}
  \definecolor{GZU@blankpagewmcolor}{gray}{0.85}

  % ----------------------------
  % 单页空白页水印：只供 shipout/background 调用
  % shipout/background 的坐标原点在页面左上角，适合放背景内容
  % ----------------------------
  \newcommand{\GZU@blankpagewatermark}{%
    \put(0,0){%
      \parbox[t][\paperheight]{\paperwidth}{%
        \centering
        \vspace*{0.3\paperheight}%
        \rotatebox{\GZU@blankpageangle}{%
          \textcolor{GZU@blankpagewmcolor}{%
            \fontsize{\GZU@blankpagefontsize}{\GZU@blankpagefontsize}\selectfont
            \GZU@blankpagetext
          }%
        }%
        \vss
      }%
    }%
  }

  % ----------------------------
  % 重定义 cleardoublepage：
  % 在双面打印时的新增页添加“此页无证文“
  % ----------------------------
  \renewcommand{\cleardoublepage}{%
    \clearpage
    \if@twoside
      \ifodd\c@page
        % 无需补空白页
      \else
        % 需要补空白页：仅这一页加背景水印
        \thispagestyle{empty}%
        \AddToHookNext{shipout/background}{\GZU@blankpagewatermark}%
        \hbox{}%
        \newpage
        \if@twocolumn
          \thispagestyle{empty}%
          \AddToHookNext{shipout/background}{\GZU@blankpagewatermark}%
          \hbox{}%
          \newpage
        \fi
      \fi
    \fi
  }

  % 可选：不是双面时给出提醒
  \AtBeginDocument{%
    \if@twoside\else
      \ClassWarning{GZUthesis}{%
        Watermark option enabled, but blank-page watermark\MessageBreak
        only takes effect in twoside mode%
      }%
    \fi
  }
\fi


%% 送审题目字体 一号 黑体
\newcommand{\GZU@font@review@title}{\zihao{1} \CJKfamily+{zhhei}}
%% 地址(贵州·贵阳)字体 黑体四号
\newcommand{\GZU@font@review@address}{ \CJKfamily+{zhhei} \zihao{4} }

%% 日期字体 黑体四号
\newcommand{\GZU@font@review@date}{ \CJKfamily+{zhhei} \zihao{4}}

%% 封面前两行信息字体
\newcommand{\GZU@font@final@faceno}{\songti \zihao{5}}
%% 分类号字体 宋体五号
\newcommand{\GZU@font@final@classfyno}{\GZU@font@final@faceno}
%% 论文编号字体 宋体五号
\newcommand{\GZU@font@final@paperno}{\GZU@font@final@faceno}
%% 论文密级字体 宋体五号
\newcommand{\GZU@font@final@seclvl}{\GZU@font@final@faceno}
%% 终版题目 黑体二号
\newcommand{\GZU@font@final@title}{\CJKfamily+{zhhei} \zihao{2}}
%% 终版地址 黑体四号
\newcommand{\GZU@font@final@address}{\heiti \zihao{4}}
%% 终版日期 黑体四号
\newcommand{\GZU@font@final@date}{\heiti \zihao{4}}
%% 终版学校字体 黑体三号
\newcommand{\GZU@font@final@university}{\heiti \zihao{3}}
%% 终版主题字体 小三号黑体
\newcommand{\GZU@font@final@topic}{ \CJKfamily+{zhhei}\zihao{-3} }
%% 终版表格字体
\newcommand{\GZU@font@final@table}{ \CJKfamily+{zhhei}\zihao{-3} }

%% 摘要标题字体 黑体、无衬线字体 小二字号
\newcommand{\GZU@font@abstitle}{\zihao{-2}\heiti \sffamily}
%% 封面表格字体 三号黑体
\newcommand{\GZU@font@review@table}{ \CJKfamily+{zhhei} \zihao{3} }
%% 摘要内容字体 宋体 默认英文字体 四号字体
\newcommand{\GZU@font@abscontent}{\songti \zihao{4}\rmfamily}
%% 关键词标题字体:黑体 四字号
\newcommand{\GZU@font@keywstitle}{\heiti \zihao{4}}
%% 关键词正文字体:宋体 四字号
\newcommand{\GZU@font@keywscontent}{\songti \zihao{4}}

%% 答辩信息页字体
\newcommand{\GZU@font@defense@topic}{\heiti\zihao{2}}
\newcommand{\GZU@font@defense@title}{\heiti \zihao{-2}}
%% 答辩页 主字体
\newcommand{\GZU@font@defense@main}{\CJKfamily+{zhhei} \zihao{-3}}


% 定义文档结构
%% 封面表格key长度
\newcommand{\GZU@table@key}[1]{
	\makebox[4em][s]{#1}
}

%% 定义摘要环境
\newenvironment{abstract}[1][摘要]{%
	\chapter*{\ }
	 {
	  \centering {\GZU@font@abstitle \uppercase{#1}}

	 }
	\addcontentsline{toc}{chapter}{\uppercase{#1}}
	\par

	\vspace{14pt}
  \setstretch{1.5}
	\GZU@font@abscontent
}{}
%% 定义关键词环境
\newcommand{\keywords}[2][关键词：]{
	\par \noindent {\GZU@font@keywstitle #1} %
	{\GZU@font@keywscontent #2}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 制作封面 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 重定义封面制作
\renewcommand{\maketitle}{
	\GZU@mktitle
}

%内部文档结构命令

%% 封面边距
\newcommand{\GZU@geometry@cover}{
	\newgeometry{top=2.9cm,bottom=2.4cm,left=2.5cm,right=2.5cm}
}


%% 制作下划线
\newcommand\dlmu[2][4cm]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}}
%% 波浪下划线
\newcommand\dlwave[2][4cm]{\hskip1pt\uwave{\hb@xt@ #1{\hss#2\hss}}}




%%% 制作封面 %%%%
\newcommand\GZU@mktitle{
	%%  根据class 参数更新内部变量
	\ifdoctor
		\global\def\GZU@final@topic{\GZU@gradyear 届博士研究生学位论文}
		\global\def\GZU@review@topic{\GZU@gradyear 届博士学位论文}
		\global\edef\GZU@defense@topic{博\GZU@defense@topic}
	\else\ifmaster
			\global\def\GZU@final@topic{\GZU@gradyear 届硕士研究生学位论文}
			\global\def\GZU@review@topic{\GZU@gradyear 届硕士学位论文}
			\global\edef\GZU@defense@topic{硕\GZU@defense@topic}
		\else
			\ClassError{GZUthesis}{type error: no impl for bachelor }
		\fi\fi
	% \GZU@topic
	\GZU@mkpage@gradtitle
}
% 制作研究生封面
\newcommand\GZU@mkpage@gradtitle{
	\GZU@geometry@cover
	\ifreview    \GZU@mkpage@gradreview\fi

	\iffinal\GZU@mkpage@gradfinal\GZU@mkpage@defense\fi

	\ifdraft\GZU@mkpage@graddraft\fi

	\restoregeometry
}

%%%%% 制作研究生封面 %%%%%%%%
% 制作盲审封面
\newcommand\GZU@mkpage@gradreview{
	\newgeometry{top=2.18cm,left=2.4cm,right=2.4cm}

	% \setlength{\fboxsep}{20.5pt}\framebox[1\width][c]{\GZU@table@paperno \GZU@tablesep \dlmu[4.3cm]{}\hskip5pt}
	~\vskip 72pt
	%
	\begin{center}
		\includegraphics[width=3.05cm]{logo/logo.eps}\\
		\includegraphics[width=4.18cm,height=1.64cm]{logo/gzdx.png}
	\end{center}
	\setstretch{1.0}
	\begin{center}
		\ziju{0.060}
		\GZU@font@review@topic{\GZU@review@topic}
	\end{center}
	\vskip 38pt
	\begin{center}
		\GZU@font@review@title
		\begin{minipage}[c][\GZU@titleheight][t]{\GZU@titlewidth}
			\begin{center}
				\GZU@title
			\end{center}
		\end{minipage}
	\end{center}
%%%% 计算文本内容宽度，方便画波浪线
  \newsavebox{\GZU@majorbox}
	\newsavebox{\GZU@researchbox}
	\newlength{\GZU@maxcontentlen}
	\newlength{\GZU@mincontentlen}
	% 设置最小长度为4cm（可以根据需要调整）
	\setlength{\GZU@mincontentlen}{4cm}
	
	% 测量专业和研究方向的宽度（考虑字体样式）
	\sbox{\GZU@majorbox}{\GZU@font@review@table \GZU@major}
	\sbox{\GZU@researchbox}{\GZU@font@review@table \GZU@research}
	
	% 取两个内容宽度的最大值
	\ifdim\wd\GZU@majorbox>\wd\GZU@researchbox
		\setlength{\GZU@maxcontentlen}{\wd\GZU@majorbox}
	\else
		\setlength{\GZU@maxcontentlen}{\wd\GZU@researchbox}
	\fi
	
	% 确保不少于4cm
	\ifdim\GZU@maxcontentlen<\GZU@mincontentlen
	\setlength{\GZU@maxcontentlen}{\GZU@mincontentlen}
	\fi
	
	% 添加一点边距（比如增加0.2cm的余量）
	\addtolength{\GZU@maxcontentlen}{0.2cm}
%%%% 计算完成

	\begin{center}
		\setstretch{1.6}
		\GZU@font@review@table
    \GZU@table@major     \GZU@tablesep     \dlwave[\GZU@maxcontentlen]{\GZU@major}\\
    \GZU@table@research  \GZU@tablesep     \dlwave[\GZU@maxcontentlen]{\GZU@research}\\
	\end{center}

	\vskip 90pt

	\begin{center}

		\setstretch{1.6}
		\GZU@font@review@address{\GZU@address}\\
		\GZU@font@review@date \GZU@date@year 年 \GZU@date@month 月


	\end{center}
	\thispagestyle{empty}
	\clearpage
	\restoregeometry
}
%% 制作最终版封面
\newcommand\GZU@mkpage@gradfinal{

	{
			\vspace{10em}
			\setstretch{0.1}
			\vskip 0.1pt
			\setstretch{1.2}
			\noindent{\GZU@font@final@classfyno \GZU@table@key{\GZU@table@classfyno} \GZU@tablesep \dlmu[2.5cm]{\GZU@classifyno}}
			\hfill
			{\GZU@font@final@seclvl \GZU@table@seclvl\GZU@tablesep\dlmu[2.5cm]{\GZU@seclvl}} \newline
			\noindent{\GZU@font@final@paperno \GZU@table@key{\GZU@table@paperno} \GZU@tablesep \dlmu[2.5cm]{\GZU@paperno}} \newline

		}
	\vskip 43.2pt
		{
			\noindent\centering\GZU@font@final@university \makebox[8em][s]{\GZU@university}

		}

		% \vskip -5pt

		{
			\noindent\centering\GZU@font@final@topic \GZU@final@topic

		}
	\vskip 120pt
	\begin{center}
		\GZU@font@final@title
		\begin{minipage}[c][\GZU@titleheight][t]{\GZU@titlewidth}
			\begin{center}
				\GZU@title
			\end{center}
		\end{minipage}
	\end{center}

	\vskip 55pt

	\noindent
	\begin{center}
		\setstretch{1.4}
		\GZU@font@final@table
		\GZU@table@key{\GZU@table@major} \GZU@tablesep \dlmu{\GZU@major}

		\GZU@table@key{\GZU@table@research} \GZU@tablesep \dlmu{\GZU@research}


		\GZU@table@key{\GZU@table@supervisor} \GZU@tablesep \dlmu{\GZU@supervisor}

		\GZU@table@key{\GZU@table@author} \GZU@tablesep \dlmu{\GZU@author}
	\end{center}
	\vskip 80pt
	\begin{center}
		\setstretch{1.6}
		\GZU@font@final@address \GZU@address
		\vskip -5pt
		\GZU@font@final@date \GZU@date@year 年 \GZU@date@month 月
	\end{center}
	\thispagestyle{empty}
	\clearpage
	\restoregeometry
}

%% 制作答辩信息页面
\newcommand\GZU@mkpage@defense{
	\thispagestyle{empty}
	~\vskip 18pt
		{
			\noindent\centering \GZU@font@defense@topic   \GZU@defense@topic

		}

	\vskip 55pt
	\noindent
	\begin{center}
		\begin{minipage}[c][\GZU@titleheight][t]{\GZU@titlewidth}
			\begin{center}
				\noindent\GZU@font@defense@title  \GZU@title
			\end{center}
		\end{minipage}
	\end{center}
	\vskip 70pt



	\hskip 65pt
	\begin{minipage}{.6\linewidth}
		\setlength{\baselineskip}{100pt}
		\renewcommand{\do}[1]{##1 \newline}%
		\begin{spacing}{1.65}
			\GZU@font@defense@main
			\GZU@defense@respondent\GZU@tablesep \GZU@author

			\GZU@defense@committee\GZU@tablesep

			\GZU@chairman \GZU@tablesep

			\dolistloop\GZU@experts
			\GZU@defense@secretary\GZU@tablesep \GZU@defsec

			\GZU@defense@date\GZU@tablesep     \GZU@defdate

			\GZU@defense@address\GZU@tablesep   \GZU@defaddr
		\end{spacing}
	\end{minipage}
}

%% 制作草稿封面
\newcommand{\GZU@mkpage@graddraft}{
	\begin{titlepage}
		\vspace*{\fill}
		\begin{center}
			{\Huge \GZU@title}\\[0.5cm]
			{\Large \GZU@author}\\[0.4cm]
			\GZU@date
		\end{center}
		\vspace*{\fill}
	\end{titlepage}
}

%% 创建新页
\newcommand{\fillblankpage}{
	\ifthenelse{\boolean{@twoside}}{%
		\clearpage
		{\thispagestyle{empty} \cleardoublepage}
	}{%
		\clearpage
		{\thispagestyle{empty} \clearpage}
	}%
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 制作封面结束 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 重定义页面样式 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %% 定义正文前的 pagestyle
\fancypagestyle{GZU@front}{
	\fancyhf{}
	\renewcommand\headrulewidth{0pt}
	\renewcommand\footrulewidth{0pt}
	\fancyfoot[C]{\thepage}
}

%% 定义正文 pagestyle
\fancypagestyle{GZU@main}{
	\fancyhf{}
	\renewcommand\headrulewidth{0.5pt}
	\renewcommand\footrulewidth{0pt}
	\fancyhead[L]{\leftmark}
	\fancyhead[R]{\protect\nouppercase\GZU@title}
	\ifthenelse{\boolean{@twoside}}{
		\fancyfoot[OR,EL]{\thepage}
	}{%
		\fancyfoot[C]{\thepage}
	}%
}

%% 内部实现 正文样式
\newcommand\GZU@mainmatter{
	\clearpage
	\setcounter{page}{1}
	\pagestyle{GZU@main}
	\pagenumbering{arabic}
	\setstretch{1.5}
}

%%% 内部实现 正文前样式
\newcommand\GZU@frontmatter{
	\pagenumbering{roman}
	\pagestyle{GZU@front}
}


\renewcommand\mainmatter{
	\GZU@mainmatter
}


\renewcommand\frontmatter{
	\GZU@frontmatter
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 重定义页面样式结束 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%重定义附录
\renewenvironment{appendices}{
	\appendix\addappheadtotoc
}{}
% 定义致谢章节
\newcommand{\acknowledgments}[1][致谢]{
	\chapter*{\centering{#1}}
	\addcontentsline{toc}{chapter}{#1}
	\markboth{#1}{#1}
}




\renewcommand{\captionfont}{\zihao{5} \heiti }


%%%%%%%%%%%%%%%%%%%%%%%%% 页边距设置 %%%%%%%%%%%%%%%%%%%%%%%%%%


%% 单页页边距
\newcommand{\GZU@mkoneside}{
	\geometry{top=2.9cm,bottom=2.4cm,left=2.5cm,right=2.5cm}
}
%% 双页页边距
\newcommand{\GZU@mktwoside}{
	\geometry{top=2.9cm,bottom=2.4cm,inner=2.9cm,outer=2.5cm}
}


% 设置文档页边距
\ifthenelse{\boolean{@twoside}}{%
	\GZU@mktwoside
}{%
	\GZU@mkoneside
}%
%%%%%%%%%%%%%%%%%%%%%%%%% 页边距设置结束 %%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%% 其他杂项设置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 终稿添加承诺书
\iffinal \ifgrad\AtEndDocument{\fillblankpage\includepdf{logo/promise.pdf}} \fi\fi

%% 自定义设置 ctex 样式
\ctexset{
	chapter={
	  format=\Large\centering\bfseries,
	  beforeskip=0pt,
	  afterskip=8pt,
	 },
	section={
	  format=\large\bfseries
	 },
	subsection={
			format=\normalsize\bfseries
		},
	appendix={
			name={附录},
		},
	bibname=\centering{参考文献}
}

%%图表设置
\captionsetup[figure][bi-second]{name=Figure}
\captionsetup[table][bi-second]{name=Table}
\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}

% 汉化
%%
\renewcommand{\appendixname}{附录}
\renewcommand{\appendixtocname}{附录}

% 目录样式
\renewcommand*\contentsname{\begin{center}目\quad 录\end{center}}
\renewcommand\listfigurename{图版}
\renewcommand\listtablename{表版}
%% 目录深度
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
\titlecontents{chapter}[0pt]{\addvspace{2pt}\filright}
{\contentspush{\thecontentslabel }\ }
{}{\titlerule*[8pt]{.}\contentspage}
\titlecontents{section}[2em]{\addvspace{2pt}\filright}
{\contentspush{\thecontentslabel }\ }
{}{\titlerule*[8pt]{.}\contentspage}
\titlecontents{subsection}[4em]{\addvspace{2pt}\filright}
{\contentspush{\thecontentslabel }\ }
{}{\titlerule*[8pt]{.}\contentspage}



\newlength{\GZU@abbrlen}
\newlength{\GZU@maxabbrlen}
\newlength{\GZU@ennomlen}
\newlength{\GZU@maxennomlen}
\newlength{\GZU@spllen}
\setlength{\GZU@spllen}{5pt}
\newcommand{\GZU@getmaxwidth}[3]{%
	\ifdim #2>#3\relax
		\setlength{#1}{#2}%
	\else
		\setlength{#1}{#3}%
	\fi
}
\pgfkeys{
	/nomgroups/.unknown/.code = {
			\pgfkeyssetvalue{\pgfkeyscurrentpath/\pgfkeyscurrentname}{#1}
		},
}

\newcommand{\setnomgroup}[2]{
	\pgfkeys{/nomgroups/#1 = #2}
}


\setnomgroup{A}{缩略语对照表}
\setnomgroup{S}{符号表}
\setnomgroup{N}{术语表}

\makenomenclature

\newcommand{\abbritem}[4][A]{#2（#3, #4）\nomenclature[A]{#4}{#3，#2}
	% \settowidth{\GZU@abbrlen}{#4}
	% \settowidth{\GZU@ennomlen}{#3}
	% \GZU@getmaxwidth{\GZU@maxabbrlen}{\GZU@abbrlen}{\GZU@maxabbrlen}
	% \GZU@getmaxwidth{\GZU@maxennomlen}{\GZU@ennomlen}{\GZU@maxennomlen}
	%\nomenclature[#1]{\parbox[t]{\GZU@maxabbrlen}{#4} \hspace{5pt} \parbox[t]{\GZU@maxennomlen+\GZU@spllen}{#3}}{\parbox[t]{\textwidth-\GZU@maxabbrlen- \GZU@maxennomlen -\GZU@maxennomlen-\GZU@spllen}{#2}}
}
\newcommand{\nomitem}[3][N]{#2（#3）\nomenclature[#1]{#3}{#2}}
\newcommand{\termitem}[3][N]{#2\nomenclature[#1]{#2}{#3}}


\renewcommand\nomgroup[1]{%
	\item[\bfseries
	            \pgfkeysvalueof{/nomgroups/#1}
	      ]}

\renewcommand{\nomname}{术语对照表}

\setstretch{1.6}
\endinput
%%
%% End of file `GZUthesis.cls'.
