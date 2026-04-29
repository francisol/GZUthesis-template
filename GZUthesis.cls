% ----------------------------------------------------------------
% GZUthesis.cls
% 贵州大学学位论文模板
% 
% Copyright (c) 2023-2025  https://github.com/francisol
% 
% 传播请注明来源，尊重作者劳动
% ----------------------------------------------------------------

% 文档类声明与基础依赖
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{GZUthesis}[2026/04/22 v2.0.0 Guizhou University Thesis Template]
\LoadClass[cs4size,a4paper,fancyhdr,fntef,oneside]{book}
\RequirePackage{xkeyval}
\RequirePackage{ifthen}
\RequirePackage{ifplatform}
\RequirePackage[intoc]{nomencl}
\RequirePackage{pgfkeys}

\def\GZU@university{贵州大学}
\def\GZU@review@topic{} % 盲审主题
\def\GZU@final@topic{} % 终稿主题
\def\GZU@defense@topic{士学位论文答辩委员会名单} % 答辩信息主题

%% 保存选项、命令设置的参数信息
\def\GZU@option@print{draft} % 打印类型
\def\GZU@option@degree{doctor} % 学位类型
\def\GZU@paperno{} % 论文号
\def\GZU@seclvl{} % 密级
\def\GZU@experts{} % 专家列表
\def\GZU@chairman{} % 答辩主席
\def\GZU@major{} % 学科专业
\def\GZU@class{} % 班级
\def\GZU@college{} % 学院
\def\GZU@research{} % 研究方向
\def\GZU@supervisor{} % 导师
\def\GZU@stuid{} % 学号
\def\GZU@title{} % 论文题目
\def\GZU@entitle{} % 论文英文题目
\def\GZU@author{} % 作者
\def\GZU@department{} % 培养单位
\def\GZU@degreecategory{} % 学位信息
\def\GZU@defaddr{} % 答辩地点
\def\GZU@gradyear{\the\year} % 毕业年份
\def\GZU@defdate{\today} % 答辩时间
\def\GZU@date{\today} % 日期
\def\GZU@defsec{} % 答辩秘书
\def\GZU@classifyno{} % 中图分类号
\def\GZU@udcno{} % UDC 分类号

%% 根据其他信息生成的变量
\def\GZU@date@year{ \the\year}
\def\GZU@date@month{ \the\month}
\def\GZU@titlewidth{14cm} % 题目宽度
\def\GZU@titleheight{7cm} % 题目区域高度

\newlength{\GZU@committee@unitwidth}
\newlength{\GZU@committee@namewidth}
\newlength{\GZU@committee@titlewidth}

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
\def\GZU@table@supervisor{导 \hfill 师\hfill 姓\hfill 名\hfill 、\hfill 职\hfill 称}
\def\GZU@table@author{学\hfill 生\hfill 姓\hfill 名}
\def\GZU@table@department{培\hfill 养\hfill 单\hfill 位}
\def\GZU@table@classfyno{中\hfill 图\hfill 分\hfill 类\hfill 号}
\def\GZU@table@stuid{学\hfill 号}
\def\GZU@table@udcno{UDC\hfill 分\hfill 类\hfill 号}
\def\GZU@table@seclvl{密\hfill 级}
\def\GZU@table@schoolno{学\hfill 校 \hfill 代\hfill 码}
\def\GZU@defense@respondent{答辩人}
\def\GZU@defense@committee{答辩委员会委员}
\def\GZU@defense@secretary{答辩秘书}
\def\GZU@defense@date{答辩日期}
\def\GZU@defense@address{答辩地点}
\def\GZU@addrsep{ {\zihao{-1}{·} }}
\def\GZU@tablesep{：}
\def\GZU@address{中国\GZU@addrsep 贵州\GZU@addrsep 贵阳} % 地址不修改
\def\GZU@schoolno{10657}
%% 状态开关
\newif\ifdoctor
\newif\ifmaster
\newif\ifbachelor
\newif\ifreview
\newif\iffinal
\newif\ifdraft
\newif\ifgrad % 是否为研究生论文
\newif\iffullfont
\newif\ifchecktnra
\newif\ifcheckhwxk
\newif\ifenablewatermark % 是否使用空白页水印
\newif\ifGZU@intable
\doctortrue
\drafttrue
\gradtrue
\checktnrafalse
\checkhwxkfalse
\enablewatermarkfalse

%%% 文档选项 %%%
% 学位类型：博士、硕士、本科
\define@choicekey*+{GZUthesis}{degree}[\val\position]{doctor,master,bachelor}[doctor]{%
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
		\ClassError{GZUthesis}{degree error: #1}{Select one of doctor, master, bachelor.}
	}
% 打印类型：草稿、盲审、终稿
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
		\ClassError{GZUthesis}{print error: #1}{Select one of draft, review, final.}
	}
% windows 同时启用 Windows 中文字体、Times/Arial 与华文行楷检查。
\DeclareOption{windows}{\fullfonttrue\checktnratrue\checkhwxktrue}
\DeclareOption{tnra}{\checktnratrue}
\DeclareOption{hwxk}{\checkhwxktrue}
\DeclareOption{watermark}{\enablewatermarktrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptionsX<GZUthesis>\relax
\RequirePackage{fontspec}
\RequirePackage[UTF8,zihao=5,heading=true]{ctex}

% 第三方宏包
\RequirePackage[titles]{tocloft}
\RequirePackage{geometry}
\RequirePackage{hyperref}
\RequirePackage[title,toc]{appendix}
\RequirePackage{setspace,titletoc,fancyhdr,pdfpages,ulem}
\RequirePackage{bicaption}

%%% 用户命令 %%%
%% 论文号
\newcommand{\paperno}[1]{\global\def\GZU@paperno{#1}}
%% 答辩秘书
\newcommand{\defsec}[1]{\global\def\GZU@defsec{#1}}

%% 答辩委员会名单内部排版工具。
\newcommand{\GZU@committee@setmaxwidth}[2]{%
	\settowidth{\@tempdima}{#2}%
	\ifdim\@tempdima>#1\relax
		\global#1=\@tempdima
	\fi
}
\newcommand{\GZU@committee@measure}[4]{%
	\GZU@committee@setmaxwidth{\GZU@committee@unitwidth}{#1}%
	\GZU@committee@setmaxwidth{\GZU@committee@namewidth}{#2}%
	\GZU@committee@setmaxwidth{\GZU@committee@titlewidth}{#3}%
}
\newcommand{\GZU@committee@spread}[2]{{\hbadness=10000\makebox[#1][s]{#2}}}
\newcommand{\GZU@committee@row}[4]{%
	\GZU@committee@spread{\GZU@committee@unitwidth}{#1} &
	\GZU@committee@spread{\GZU@committee@namewidth}{#2} &
	\GZU@committee@spread{\GZU@committee@titlewidth}{#3}#4\\
}
\let\GZU@committee@entry\GZU@committee@row
%% 添加答辩专家
\newcommand{\addexpert}[3]{%
	\listadd{\GZU@experts}{\GZU@committee@entry{#1}{#2}{#3}{}}%
}
%% 答辩主席
\newcommand{\chairman}[3]{%
	\global\def\GZU@chairman{\GZU@committee@entry{#1}{#2}{#3}{（主席）}}%
}
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
%% 英文题目
\newcommand{\entitle}[1]{\global\def\GZU@entitle{#1}}
%% 作者
\renewcommand{\author}[1]{\global\def\GZU@author{#1}}
\newcommand{\department}[1]{\global\def\GZU@department{#1}}
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
%% 中图分类号
\newcommand{\classifyno}[1]{\global\def\GZU@classifyno{#1}}
%% UDC 分类号
\newcommand{\udcno}[1]{\global\def\GZU@udcno{#1}}
\newcommand{\degreecategory}[1]{\global\def\GZU@degreecategory{#1}}

%%%%%%%%%%%%%%%%%%%%%%%% 字体处理 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 主题字体默认楷体；启用华文行楷后会重定义。
\newcommand{\GZU@font@review@topic}{\zihao{-0} \CJKfamily+{zhkai}}
%% 终稿学校名称字体默认楷体；启用华文行楷后会重定义。
\newcommand{\GZU@font@final@university}{\bfseries \fontsize{29bp}{35bp}\selectfont \CJKfamily+{zhkai} \ziju{0.2}}

%% 注册华文行楷字体族。加粗使用伪粗，避免查找不存在或不兼容的粗体文件。
\newcommand{\GZU@sethwxkfont}[1]{%
	\setCJKfamilyfont{hwxk}[AutoFakeBold=2.5]{#1}%
	\renewcommand{\GZU@font@review@topic}{\zihao{-0} \CJKfamily+{hwxk}}%
	\renewcommand{\GZU@font@final@university}{\bfseries\fontsize{29bp}{35bp}\selectfont \CJKfamily+{hwxk}\ziju{0.2}}%
}

%% 检查并启用华文行楷。系统字体名优先，其次查找当前目录下的 STXINGKA.TTF。
\newcommand{\GZU@hwxkcheck}{%
	\ifwindows
		\def\xingkainame{STXINGKA}%
	\else
		\def\xingkainame{STXingkai}%
	\fi
	\IfFontExistsTF{\xingkainame}{%
		\GZU@sethwxkfont{\xingkainame}%
	}{%
		\IfFontExistsTF{STXINGKA.TTF}{%
			\GZU@sethwxkfont{STXINGKA.TTF}%
		}{}%
	}%
}

%% 检查并启用 Times New Roman 与 Arial。
\newcommand{\GZU@tnracheck}{%
	\IfFontExistsTF{Times New Roman}{%
		\setmainfont{Times New Roman}%
	}{}%
	\IfFontExistsTF{Arial}{%
		\setsansfont{Arial}%
	}{}%
}

%% 检查并启用 Windows 常用中文字体。
\newcommand{\GZU@usewindowsfont}{%
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
		\setCJKmainfont[AutoFakeBold=2.5,ItalicFont=\GZU@fontname@kai]{\GZU@fontname@song}
		\setCJKmonofont{\GZU@fontname@fsong}
		\setCJKfamilyfont{zhsong}[AutoFakeBold=2.5,ItalicFont=\GZU@fontname@kai]{\GZU@fontname@song}
		\setCJKfamilyfont{zhhei}{\GZU@fontname@hei}
		\setCJKfamilyfont{zhfs}{\GZU@fontname@fsong}
		\setCJKfamilyfont{zhkai}{\GZU@fontname@kai}
	\fi
}

\iffullfont\GZU@usewindowsfont\fi
\ifchecktnra\GZU@tnracheck\fi
\ifcheckhwxk\GZU@hwxkcheck\fi

\ifenablewatermark
	\RequirePackage[final]{draftwatermark}
	\RequirePackage{xcolor}
	\RequirePackage{graphicx}

	% 空白页水印控制参数。
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

	% shipout/background 的坐标原点在页面左上角，适合放背景内容。
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

	% 双面打印补空白页时添加“此页无正文”水印。
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

	% 单面模式下不会产生双面补空白页，给出提醒。
	\AtBeginDocument{%
		\if@twoside\else
			\ClassWarning{GZUthesis}{%
				Watermark option enabled, but blank-page watermark\MessageBreak
				only takes effect in twoside mode%
			}%
		\fi
	}
\fi

%%%%%%%%%%%%%%%%%%%%%%%% 字体样式 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 盲审题目字体：一号黑体
\newcommand{\GZU@font@review@title}{\zihao{1} \CJKfamily+{zhhei}}
%% 盲审地址字体：黑体四号
\newcommand{\GZU@font@review@address}{ \CJKfamily+{zhhei} \zihao{4} }
%% 盲审日期字体：黑体四号
\newcommand{\GZU@font@review@date}{ \CJKfamily+{zhhei} \zihao{4}}

%% 终稿封面顶部信息字体：宋体五号
\newcommand{\GZU@font@final@faceno}{\songti \zihao{5}}
\newcommand{\GZU@font@final@classfyno}{\GZU@font@final@faceno}
\newcommand{\GZU@font@final@udcno}{\GZU@font@final@faceno}
\newcommand{\GZU@font@final@paperno}{\GZU@font@final@faceno}
\newcommand{\GZU@font@final@seclvl}{\GZU@font@final@faceno}
%% 终稿标题字体：20bp
\newcommand{\GZU@font@final@title}{\fontsize{20bp}{24bp}\selectfont }
%% 终稿地址字体：黑体 14bp
\newcommand{\GZU@font@final@address}{\heiti \fontsize{14bp}{17bp}\selectfont  }
%% 终稿日期字体：黑体 14bp
\newcommand{\GZU@font@final@date}{\heiti \fontsize{14bp}{17bp}\selectfont }

%% 终稿论文类型字体：宋体伪粗 20bp
\newcommand{\GZU@font@final@topic}{\CJKfamily{zhsong}\bfseries\fontsize{20bp}{24bp}\selectfont \addfontfeatures{LetterSpace=10}\ziju{0.5} }
\newcommand{\GZU@font@final@degreecategory}{
  \CJKfamily{zhsong}\bfseries\fontsize{16.5bp}{20bp} \selectfont%
}

%% 终稿封面表格字体：宋体 14bp
\newcommand{\GZU@font@final@table}{ \CJKfamily+{zhsong}\fontsize{14bp}{17bp}\selectfont }

%% 摘要标题字体：黑体/无衬线 小二
\newcommand{\GZU@font@abstitle}{\zihao{-2}\heiti \sffamily}
%% 盲审封面表格字体：三号黑体
\newcommand{\GZU@font@review@table}{ \CJKfamily+{zhhei} \zihao{3} }
%% 摘要内容字体：宋体四号
\newcommand{\GZU@font@abscontent}{\songti \zihao{4}}
%% 关键词标题字体：宋体四号加粗
\newcommand{\GZU@font@keywstitle}{\songti  \zihao{4}}
%% 关键词正文字体：宋体四号
\newcommand{\GZU@font@keywscontent}{\songti \zihao{4}}

%% 答辩信息页字体
\newcommand{\GZU@font@defense@topic}{\heiti\zihao{2}}
\newcommand{\GZU@font@defense@title}{\heiti \zihao{-2}}
\newcommand{\GZU@font@defense@main}{\CJKfamily+{zhsong} \fontsize{14bp}{17bp}\selectfont}


%%%%%%%%%%%%%%%%%%%%%%%% 文档结构命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 固定宽度标签；第一个参数为宽度，单位为汉字宽度。
\newcommand{\GZU@table@key}[2][4]{%
	\makebox[#1\ccwd][s]{#2}%
}
%% 固定宽度顶部标签；第一个参数为显式 TeX 长度。
\newcommand{\GZU@top@key}[2][2cm]{%
	\makebox[#1][s]{#2}%
}

%% 摘要环境。可选参数 cn 生成中文摘要标题，否则生成英文摘要标题。
\newenvironment{abstract}[1][cn]{%
  \begin{center}
    \setstretch{1.8}%
    \GZU@font@abstitle
      \ifstrequal{#1}{cn}{%
        \GZU@title
      }{%
        \GZU@entitle
      }%
  \end{center}
  \addcontentsline{toc}{chapter}{%
    \ifstrequal{#1}{cn}{摘要}{ABSTRACT}%
  }%
  \par
  \vspace{14pt}%
  \setstretch{1.5}%
  \GZU@font@abscontent
  \noindent
  \ifstrequal{#1}{cn}{摘要：}{Abstract:}%
}{%
  \clearpage
}
%% 关键词命令。
\newcommand{\keywords}[2][关键词：]{%
  \vspace{16pt}
	\par \noindent {\GZU@font@keywstitle #1} %
	{\GZU@font@keywscontent #2}
}


%%%%%%%%%%%%%%%%%%%%%%%% 封面与题名页 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 重定义封面制作入口。
\renewcommand{\maketitle}{%
	\GZU@mktitle
}

%% 封面边距。
\newcommand{\GZU@geometry@cover}{%
	\newgeometry{top=2.9cm,bottom=2.4cm,left=2.5cm,right=2.5cm}
}

%% 居中下划线与波浪下划线。
\newcommand\dlmu[2][4cm]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}}
\newcommand\dlwave[2][4cm]{\hskip1pt\uwave{\hb@xt@ #1{\hss#2\hss}}}

%% 将长度寄存器设置为当前值与候选值中的较大者。
\newcommand{\GZU@setmaxwidth}[2]{%
	\ifdim #2>#1\relax
		\setlength{#1}{#2}%
	\fi
}

\newlength{\GZU@covermincontentlen}
\newlength{\GZU@covercontentpadding}
\setlength{\GZU@covermincontentlen}{4cm}
\setlength{\GZU@covercontentpadding}{0.2cm}

\newsavebox{\GZU@reviewmajorbox}
\newsavebox{\GZU@reviewresearchbox}
\newlength{\GZU@reviewmaxcontentlen}

\newsavebox{\GZU@finalmajorbox}
\newsavebox{\GZU@finalresearchbox}
\newsavebox{\GZU@finalsupervisorbox}
\newsavebox{\GZU@finalauthorbox}
\newlength{\GZU@finalmaxcontentlen}
%% 根据论文类型设置封面主题并制作题名页。
\newcommand\GZU@mktitle{%
	\ifdoctor
		\global\def\GZU@final@topic{博士学位论文}
		\global\def\GZU@review@topic{\GZU@gradyear 届博士学位论文}
		\global\edef\GZU@defense@topic{博\GZU@defense@topic}
	\else\ifmaster
			\global\def\GZU@final@topic{硕士学位论文}
			\global\def\GZU@review@topic{\GZU@gradyear 届硕士学位论文}
			\global\edef\GZU@defense@topic{硕\GZU@defense@topic}
			\else
				\ClassError{GZUthesis}{type error: no impl for bachelor}{Bachelor thesis cover is not implemented.}
			\fi\fi
	\GZU@mkpage@gradtitle
}

%% 制作研究生题名页。
\newcommand\GZU@mkpage@gradtitle{%
	\GZU@geometry@cover
	\ifreview    \GZU@mkpage@gradreview\fi

	\iffinal\GZU@mkpage@gradfinal\GZU@mkpage@defense\fillblankpage\includepdf{logo/promise.pdf}\fi

	\ifdraft\GZU@mkpage@graddraft\fi

	\restoregeometry
}

%% 制作盲审封面。
\newcommand\GZU@mkpage@gradreview{%
	\newgeometry{top=2.18cm,left=2.4cm,right=2.4cm}

	~\vskip 40pt
	\begin{center}
		\includegraphics[width=3.05cm]{logo/logo.eps}\\
		\includegraphics[width=4.18cm,height=1.64cm]{logo/gzdx.eps}
	\end{center}
	\setstretch{1.0}
	\begin{center}
		\ziju{0.060}
		\GZU@font@review@topic{\GZU@review@topic}
	\end{center}
	\vskip 30pt
	\begin{center}
		\GZU@font@review@title
		\begin{minipage}[c][\GZU@titleheight][t]{\GZU@titlewidth}
			\begin{center}
				\GZU@title
			\end{center}
		\end{minipage}
	\end{center}
	%% 计算文本内容宽度，方便画波浪线。
	\sbox{\GZU@reviewmajorbox}{\GZU@font@review@table \GZU@major}
	\sbox{\GZU@reviewresearchbox}{\GZU@font@review@table \GZU@research}
	\setlength{\GZU@reviewmaxcontentlen}{\wd\GZU@reviewmajorbox}
	\GZU@setmaxwidth{\GZU@reviewmaxcontentlen}{\wd\GZU@reviewresearchbox}
	\GZU@setmaxwidth{\GZU@reviewmaxcontentlen}{\GZU@covermincontentlen}
	\addtolength{\GZU@reviewmaxcontentlen}{\GZU@covercontentpadding}
	~\hspace{1cm}
	\begin{center}
		\setstretch{1.6}
		\GZU@font@review@table
		\GZU@table@major     \GZU@tablesep     \dlwave[\GZU@reviewmaxcontentlen]{\GZU@major}\\
		\GZU@table@research  \GZU@tablesep     \dlwave[\GZU@reviewmaxcontentlen]{\GZU@research}\\
	\end{center}

	\vskip 60pt

	\begin{center}

		\setstretch{1.6}
		\GZU@font@review@address{\GZU@address}\\
		\GZU@font@review@date \GZU@date@year 年 \GZU@date@month 月


	\end{center}
	\thispagestyle{empty}
	\clearpage
	\restoregeometry
}
%% 制作终稿封面。
\newcommand\GZU@mkpage@gradfinal{%
	~\vskip -30pt
	%% 顶部信息。
	\noindent\begin{minipage}{\textwidth}
		\setstretch{1.2}
		\noindent{\GZU@font@final@classfyno \GZU@top@key{\GZU@table@classfyno}\GZU@tablesep \dlmu[2.5cm]{\GZU@classifyno}}
		\hfill
		{\GZU@font@final@seclvl \GZU@top@key[1.8cm]{\GZU@table@schoolno}\GZU@tablesep\dlmu[2.5cm]{\GZU@schoolno}}

		\noindent{\GZU@font@final@udcno \GZU@top@key{\GZU@table@udcno}\GZU@tablesep \dlmu[2.5cm]{\GZU@udcno}}
		\hfill
		{\GZU@font@final@seclvl \GZU@top@key[1.8cm]{\GZU@table@seclvl}\GZU@tablesep \dlmu[2.5cm]{\GZU@seclvl}}
	\end{minipage}

	\vspace{70pt}

	\noindent\begin{minipage}{\textwidth}
		\setstretch{1.6}
		\begin{center}
			{\GZU@font@final@university{\GZU@university}}

			\vspace{16pt}

			{\GZU@font@final@topic \GZU@final@topic}

			\vspace{12pt}
			{\GZU@font@final@degreecategory \GZU@degreecategory}
		\end{center}
	\end{minipage}
	\vspace{18pt}
	\begin{center}
		\GZU@font@final@title
		\begin{minipage}[c][\GZU@titleheight][t]{\GZU@titlewidth}
			\begin{center}
				\GZU@title

				\vspace{10pt}

				\GZU@entitle
			\end{center}
		\end{minipage}
	\end{center}

	\vspace{18pt}

	%% 计算终稿封面表格内容宽度，方便画下划线。
	\sbox{\GZU@finalmajorbox}{\GZU@font@final@table \GZU@major}
	\sbox{\GZU@finalresearchbox}{\GZU@font@final@table \GZU@research}
	\sbox{\GZU@finalsupervisorbox}{\GZU@font@final@table \GZU@supervisor}
	\sbox{\GZU@finalauthorbox}{\GZU@font@final@table \GZU@author}
	\setlength{\GZU@finalmaxcontentlen}{\wd\GZU@finalmajorbox}
	\GZU@setmaxwidth{\GZU@finalmaxcontentlen}{\wd\GZU@finalresearchbox}
	\GZU@setmaxwidth{\GZU@finalmaxcontentlen}{\wd\GZU@finalsupervisorbox}
	\GZU@setmaxwidth{\GZU@finalmaxcontentlen}{\wd\GZU@finalauthorbox}
	\GZU@setmaxwidth{\GZU@finalmaxcontentlen}{\GZU@covermincontentlen}
	\addtolength{\GZU@finalmaxcontentlen}{\GZU@covercontentpadding}
	\noindent
	\begin{center}
		\setstretch{1.5}
		\GZU@font@final@table
		\GZU@table@key[7]{\GZU@table@author}\GZU@tablesep \dlmu[\GZU@finalmaxcontentlen]{\GZU@author}

		\GZU@table@key[7]{\GZU@table@stuid}\GZU@tablesep \dlmu[\GZU@finalmaxcontentlen]{\GZU@stuid}

		\GZU@table@key[7]{\GZU@table@supervisor}\GZU@tablesep \dlmu[\GZU@finalmaxcontentlen]{\GZU@supervisor}

		\GZU@table@key[7]{\GZU@table@major}\GZU@tablesep \dlmu[\GZU@finalmaxcontentlen]{\GZU@major}

		\GZU@table@key[7]{\GZU@table@research}\GZU@tablesep \dlmu[\GZU@finalmaxcontentlen]{\GZU@research}

		\GZU@table@key[7]{\GZU@table@department}\GZU@tablesep \dlmu[\GZU@finalmaxcontentlen]{\GZU@department}
	\end{center}
	\vspace{50pt}
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

%% 制作答辩信息页。
\newcommand\GZU@mkpage@defense{%
	\thispagestyle{empty}

	~\vskip 60pt

\noindent\centering{\GZU@font@defense@topic \GZU@defense@topic}

	\vspace{55pt}
	\noindent
	\begin{center}
		\begin{minipage}[c][8\ccwd][t]{\GZU@titlewidth}
			\begin{center}
				\noindent\GZU@font@defense@title  \GZU@title
			\end{center}
		\end{minipage}
	\end{center}
	\vskip 60pt

	\hskip 40pt
	\begin{minipage}{.6\linewidth}
		\renewcommand{\do}[1]{##1}%
		\begin{spacing}{1.6}
			\GZU@font@defense@main
			\GZU@defense@respondent\GZU@tablesep \GZU@author

			\GZU@defense@committee\GZU@tablesep\par
			\setlength{\GZU@committee@unitwidth}{0pt}%
			\setlength{\GZU@committee@namewidth}{0pt}%
			\setlength{\GZU@committee@titlewidth}{0pt}%
			{\let\GZU@committee@entry\GZU@committee@measure
				\GZU@chairman
				\dolistloop\GZU@experts}%
			\begin{tabular}[t]{@{}l@{\hspace{5em}}l@{\hspace{2em}}l@{}}
				\GZU@font@defense@main
				\GZU@chairman
				\dolistloop\GZU@experts
			\end{tabular}
			\vspace{-10pt}

			\GZU@defense@secretary\GZU@tablesep \GZU@defsec

			\GZU@defense@date\GZU@tablesep     \GZU@defdate

			\GZU@defense@address\GZU@tablesep   \GZU@defaddr
		\end{spacing}
	\end{minipage}
}

%% 制作草稿封面。
\newcommand{\GZU@mkpage@graddraft}{%
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

%% 按单双面模式插入空白页。
\newcommand{\fillblankpage}{%
	\ifthenelse{\boolean{@twoside}}{%
		\clearpage
		{\thispagestyle{empty} \cleardoublepage}
	}{%
		\clearpage
		{\thispagestyle{empty} \clearpage}
	}%
}
%%%%%%%%%%%%%%%%%%%%%%%% 页面样式 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 正文前页码样式。
\fancypagestyle{GZU@front}{%
	\fancyhf{}
	\renewcommand\headrulewidth{0pt}
	\renewcommand\footrulewidth{0pt}
	\fancyfoot[C]{\thepage}
}

%% 正文页眉页脚样式。
\fancypagestyle{GZU@main}{%
	\fancyhf{}
	\renewcommand\headrulewidth{0.5pt}
	\renewcommand\footrulewidth{0pt}
	\fancyhead[C]{\leftmark}
		\ifthenelse{\boolean{@twoside}}{
		\fancyfoot[OR,EL]{\thepage}
	}{%
		\fancyfoot[C]{\thepage}
	}%
}

%% 正文开始时重置页码并切换为阿拉伯数字。
\newcommand\GZU@mainmatter{%
	\clearpage
	\setcounter{page}{1}
	\pagestyle{GZU@main}
	\pagenumbering{arabic}
	\setstretch{1.5}
}

%% 正文前使用罗马数字页码。
\newcommand\GZU@frontmatter{%
	\pagenumbering{roman}
	\pagestyle{GZU@front}
}

\renewcommand\mainmatter{%
	\GZU@mainmatter
}

\renewcommand\frontmatter{%
	\GZU@frontmatter
}

%%%%%%%%%%%%%%%%%%%%%%%% 正文结构辅助命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 重定义 appendices 环境，自动写入目录。
\renewenvironment{appendices}{%
	\newpage{}
	\appendix\addappheadtotoc
}{}
%% 定义致谢章节。
\newcommand{\GZU@font@acknowledgments@title}{\zihao{5}\heiti}
\newcommand{\acknowledgmentscontentfont}{\zihao{5}\kaishu}
\newenvironment{acknowledgmentscontent}{%
	\par\acknowledgmentscontentfont
}{%
	\par
}
\newcommand{\acknowledgments}[1][致谢]{%
	\clearpage{}
	{\centerline{\GZU@font@acknowledgments@title #1}}
	\vskip 8pt
	\addcontentsline{toc}{chapter}{#1}
	\markboth{#1}{#1}
}

%% 图表、参考文献与表格正文字体。
\newcommand{\GZU@font@smallfivesong}{\zihao{-5}\songti}
\newcommand{\GZU@font@smallfivehei}{\zihao{-5}\heiti}
\newcommand{\GZU@font@bibliography@title}{\zihao{-4}\heiti}
\newcommand{\GZU@font@bibliography@content}{\zihao{-5}\songti}
\DeclareCaptionFont{GZU@captionfont}{\GZU@font@smallfivesong}
\DeclareCaptionFont{GZU@captionlabelfont}{\GZU@font@smallfivehei}
\AtBeginEnvironment{table}{\GZU@intabletrue}
\AtEndEnvironment{table}{\GZU@intablefalse}
\AtBeginEnvironment{tabular}{\ifGZU@intable\GZU@font@smallfivesong\fi}
\AtBeginEnvironment{tabular*}{\ifGZU@intable\GZU@font@smallfivesong\fi}
\AtBeginEnvironment{longtable}{\GZU@font@smallfivesong}
\newcommand{\GZU@setupbiblatex}{%
	\@ifpackageloaded{biblatex}{%
		\renewcommand*{\bibfont}{\GZU@font@bibliography@content}%
		\defbibheading{bibliography}[\bibname]{%
			\chapter*{\centering{\GZU@font@bibliography@title ##1}}%
			\addcontentsline{toc}{chapter}{##1}%
			\markboth{##1}{##1}%
		}%
		\defbibheading{bibintoc}[\bibname]{%
			\chapter*{\centering{\GZU@font@bibliography@title ##1}}%
			\addcontentsline{toc}{chapter}{##1}%
			\markboth{##1}{##1}%
		}%
		\defbibheading{bibnumbered}[\bibname]{%
			\chapter{\GZU@font@bibliography@title ##1}%
		}%
	}{}%
}
\AtBeginDocument{\GZU@setupbiblatex}

%%%%%%%%%%%%%%%%%%%%%%%% 页边距设置 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 单面页边距。
\newcommand{\GZU@mkoneside}{%
	\geometry{top=2.9cm,bottom=2.4cm,left=2.5cm,right=2.5cm}
}
%% 双面页边距。
\newcommand{\GZU@mktwoside}{%
	\geometry{top=2.9cm,bottom=2.4cm,inner=2.8cm,outer=2.2cm}
}


%% 设置正文页边距。
\ifthenelse{\boolean{@twoside}}{%
	\GZU@mktwoside
}{%
	\GZU@mkoneside
}%

%%%%%%%%%%%%%%%%%%%%%%%% 章节、目录与编号 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 自定义 ctex 章节样式。
\ctexset{
	chapter={
		format=\large\centering\heiti\bfseries,
		fixskip=true,
		beforeskip=0pt,
		afterskip=20pt,
	},
	section={
		fixskip=true,
		beforeskip=16pt,
		afterskip=16pt,
		format=\normalsize\heiti\bfseries,
	},
	subsection={
		fixskip=true,
		beforeskip=12pt,
		afterskip=12pt,
		format=\normalsize\heiti\bfseries,
	},
  subsubsection={
		fixskip=true,
		beforeskip=12pt,
		afterskip=12pt,
		format=\normalsize\heiti\bfseries,
	},
	bibname=\centering{参考文献}
}
%% 图表与公式编号。
\captionsetup[figure][bi-second]{name=Figure}
\captionsetup[table][bi-second]{name=Table}
\captionsetup[figure]{font=GZU@captionfont,labelfont=GZU@captionlabelfont,justification=centering,singlelinecheck=true}
\captionsetup[table]{font=GZU@captionfont,labelfont=GZU@captionlabelfont}
\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}
\renewcommand{\theequation}{\arabic{chapter}-\arabic{equation}}

%% 汉化附录名称。
\renewcommand{\appendixname}{附录}
\renewcommand{\appendixtocname}{附录}

%% 目录样式。
\renewcommand*\contentsname{\begin{center}目\quad 录\end{center}}
\renewcommand\listfigurename{图目录}
\renewcommand\listtablename{表目录}

\let\GZU@listoffigures\listoffigures
\renewcommand{\listoffigures}{%
	\begingroup
	\renewcommand*{\addvspace}[1]{}%
	\GZU@listoffigures
	\endgroup
}
\let\GZU@listoftables\listoftables
\renewcommand{\listoftables}{%
	\begingroup
	\renewcommand*{\addvspace}[1]{}%
	\GZU@listoftables
	\endgroup
}

%% 目录深度与目录项样式。
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
\newcommand{\GZU@tocdot}{\raisebox{0.35ex}{.}}
\renewcommand{\cftdot}{\GZU@tocdot}
\titlecontents{chapter}[0pt]{\filright}
{\contentspush{\thecontentslabel }\ }
{}{\titlerule*[8pt]{\GZU@tocdot}\contentspage}
\titlecontents{section}[2em]{\filright}
{\contentspush{\thecontentslabel }\ }
{}{\titlerule*[8pt]{\GZU@tocdot}\contentspage}
\titlecontents{subsection}[4em]{\filright}
{\contentspush{\thecontentslabel }\ }
{}{\titlerule*[8pt]{\GZU@tocdot}\contentspage}

%%%%%%%%%%%%%%%%%%%%%%%% 缩略语、术语与符号表 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pgfkeys{
	/nomgroups/.unknown/.code = {
		\pgfkeyssetvalue{\pgfkeyscurrentpath/\pgfkeyscurrentname}{#1}
	},
}

\newcommand{\setnomgroup}[2]{%
	\pgfkeys{/nomgroups/#1 = #2}%
}

\setnomgroup{A}{缩略语对照表}
\setnomgroup{S}{符号表}
\setnomgroup{N}{术语表}

\makenomenclature
%% 缩略语登记：参数为中文、英文、缩写；固定写入 A 组，不在当前位置输出正文。
\newcommand{\abbrdef}[3]{%
	\nomenclature[A]{\protect\makebox[0.15\textwidth][l]{#3}\hspace{0.02\textwidth}\protect\parbox[t]{0.4\textwidth}{#2}}{\hspace{0.03\textwidth}\protect\parbox[t]{0.4\textwidth}{#1}}%
}
%% 缩略语：参数为中文、英文、缩写；当前位置输出“中文（英文，缩写）”。
\newcommand{\abbritem}[3]{#1（#2, #3）\abbrdef{#1}{#2}{#3}}
%% 术语登记：参数为左列、右列；固定写入 N 组，不在当前位置输出正文。
\newcommand{\nomdef}[2]{%
	\nomenclature[N]{\protect\parbox[t]{0.25\textwidth}{#1}}{\hspace{0.05\textwidth}\protect\parbox[t]{0.7\textwidth}{#2}}%
}
%% 双语术语：参数为中文、英文；当前位置输出“中文（英文）”。
\newcommand{\nomitem}[2]{#1（#2）\nomdef{#1}{#2}}
%% 中文术语：参数为术语、解释；当前位置输出“术语”。
\newcommand{\termitem}[2]{#1\nomdef{#1}{#2}}

%% 符号登记：参数为符号、说明；固定写入 S 组。
\newcommand{\symbolitem}[2]{%
	\nomenclature[S]{\protect\parbox[t]{0.1\textwidth}{#1}}{\hspace{20pt}\protect\parbox[t]{0.66\textwidth}{#2}}%
}
\renewcommand\nomgroup[1]{%
	\item[\heiti\normalsize\pgfkeysvalueof{/nomgroups/#1}]%
}
\let\GZU@orig@thenomenclature\thenomenclature
\let\GZU@orig@endthenomenclature\endthenomenclature

%% 重定义术语表环境的间距。
\renewenvironment{thenomenclature}{%
	\GZU@orig@thenomenclature
	\setlength{\itemsep}{8pt}
	\setlength{\parsep}{10pt}
	\setlength{\topsep}{8pt}
	\setlength{\partopsep}{10pt}
	\setstretch{1.0}
}{%
	\GZU@orig@endthenomenclature
	\newpage{}
}
\renewcommand{\nomname}{缩略语、术语、符号对照表}

\endinput
%%
%% End of file `GZUthesis.cls'.
