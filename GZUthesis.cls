% ----------------------------------------------------------------
% GZUthesis.cls
% 贵州大学学位论文模板
% 
% Copyright (c) 2023-2026  https://github.com/francisol
% 
% 传播请注明来源，尊重作者劳动
% ----------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%% 类声明与基础依赖 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{GZUthesis}[2026/07/22 v2.1.0 Guizhou University Thesis Template]
\LoadClass[cs4size,a4paper,fancyhdr,fntef,oneside]{book}
\RequirePackage{xkeyval}
\RequirePackage{ifthen}
\RequirePackage{ifplatform}
\RequirePackage[intoc]{nomencl}
\RequirePackage{pgfkeys}

%%%%%%%%%%%%%%%%%%%%%%%% 内部变量与常量 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 模板固定信息。
\def\GZU@university{贵州大学} % 学校名称
\def\GZU@review@topic{} % 盲审封面主题
\def\GZU@final@topic{} % 终稿封面主题
\def\GZU@defense@topic{士学位论文答辩委员会名单} % 答辩信息页标题后缀
\def\GZU@schoolno{10657}

%% 保存选项和用户命令写入的论文信息。
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
\def\GZU@defense@pdf{} % 已签字答辩委员会名单扫描件
\def\GZU@promise@student@signature{} % 原创性声明学生签名
\def\GZU@promise@supervisor@signature{} % 授权声明导师签名
\def\GZU@promise@student@width{2.55cm}
\def\GZU@promise@supervisor@width{2.55cm}
\def\GZU@promise@date@year{\the\year}
\def\GZU@promise@date@month{\the\month}
\def\GZU@promise@date@day{\the\day}
\def\GZU@promise@secret@years{}
\def\GZU@promise@orig@student@x{9.0cm}
\def\GZU@promise@orig@student@y{18.65cm}
\def\GZU@promise@auth@student@x{8.90cm}
\def\GZU@promise@auth@student@y{5.48cm}
\def\GZU@promise@auth@supervisor@x{14.25cm}
\def\GZU@promise@auth@supervisor@y{4.83cm}
\def\GZU@promise@orig@date@y{18.38cm}
\def\GZU@promise@auth@date@y{4.10cm}
\newif\ifGZU@promise@secret
\GZU@promise@secretfalse

%% 根据其他信息生成或排版时复用的变量。
\def\GZU@date@year{ \the\year}
\def\GZU@date@month{ \the\month}
\def\GZU@titlewidth{14cm} % 题目宽度
\def\GZU@titleheight{7cm} % 题目区域高度

%% 答辩委员会名单排版用长度。
\newlength{\GZU@committee@unitwidth}
\newlength{\GZU@committee@namewidth}
\newlength{\GZU@committee@titlewidth}

%% 封面下划线长度计算用长度与盒子。
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

%% 将中文日期拆为年月，供封面显示。
\def\GZU@date@nil{\GZU@date@nil}
\def\parsedate#1年#2月#3\endparse{%
	\global\def\GZU@date@year{#1}
	\global\def\GZU@date@month{#2}
}
\def\GZU@parsedate#1{%
	\GZU@@parsedate#1年\GZU@date@nil月\GZU@date@nil\endparse
}
\def\GZU@@parsedate#1年#2月#3\endparse{%
	\def\GZU@date@testmonth{#2}%
	\ifx\GZU@date@testmonth\GZU@date@nil
	\else
		\parsedate#1年#2月#3\endparse
	\fi
}

%% 封面、答辩页和目录中使用的固定文本。
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

\def\GZU@addrsep{%
  \hspace{0.4em}%
  \raisebox{0.4ex}{\rule{0.26em}{0.26em}}%
  \hspace{0.4em}%
}
\def\GZU@tablesep{：}
\def\GZU@address{中国\GZU@addrsep 贵州\GZU@addrsep 贵阳} % 地址不修改

%%%%%%%%%%%%%%%%%%%%%%%% 状态开关与文档选项 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 论文类型、打印类型和可选功能开关。
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
\newif\ifGZU@topics@ready
\doctortrue
\drafttrue
\gradtrue
\checktnrafalse
\checkhwxkfalse
\enablewatermarkfalse
\GZU@topics@readyfalse

%% 学位类型：博士、硕士、本科。
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
%% 打印类型：草稿、盲审、终稿。
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
%% windows 同时启用 Windows 中文字体、Times/Arial 与华文行楷检查。
\DeclareOption{windows}{\fullfonttrue\checktnratrue\checkhwxktrue}
\DeclareOption{tnra}{\checktnratrue}
\DeclareOption{hwxk}{\checkhwxktrue}
\DeclareOption{watermark}{\enablewatermarktrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptionsX<GZUthesis>\relax

%%%%%%%%%%%%%%%%%%%%%%%% 第三方宏包 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{fontspec}
\RequirePackage[UTF8,zihao=5,heading=true]{ctex}
\RequirePackage[titles]{tocloft}
\RequirePackage{geometry}
\RequirePackage{hyperref}
\RequirePackage[title,toc]{appendix}
\RequirePackage{setspace,titletoc,fancyhdr,pdfpages,ulem}
\RequirePackage{graphicx,tikz}
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
	\GZU@committee@spread{\GZU@committee@titlewidth}{#3} &
	\GZU@tablesep\makebox[6em]{\rule{6em}{0.4pt}}#4\\
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
%% 使用已签字的答辩委员会名单扫描件
\newcommand{\defensepdf}[1]{\global\def\GZU@defense@pdf{#1}}
\newcommand{\cleardefensepdf}{\global\def\GZU@defense@pdf{}}
%% 毕业年份
\newcommand{\gradyear}[1]{\global\def\GZU@gradyear{#1}}
%% 答辩时间
\newcommand{\defdate}[1]{\global\def\GZU@defdate{#1}}
%% 日期
\renewcommand{\date}[1]{%
	\global\def\GZU@date{#1}%
	\global\def\GZU@defdate{#1}%
	\GZU@parsedate{#1}%
}
%% 密级
\newcommand{\seclvl}[1]{\global\def\GZU@seclvl{#1}}
%% 中图分类号
\newcommand{\classifyno}[1]{\global\def\GZU@classifyno{#1}}
%% UDC 分类号
\newcommand{\udcno}[1]{\global\def\GZU@udcno{#1}}
\newcommand{\degreecategory}[1]{\global\def\GZU@degreecategory{#1}}
%% 原创性声明与授权声明签名
\newcommand{\studentsignature}[2][2.55cm]{%
	\global\def\GZU@promise@student@width{#1}%
	\global\def\GZU@promise@student@signature{#2}%
}
\newcommand{\supervisorsignature}[2][2.55cm]{%
	\global\def\GZU@promise@supervisor@width{#1}%
	\global\def\GZU@promise@supervisor@signature{#2}%
}
\let\advisorsignature\supervisorsignature
\newcommand{\promisedate}[3]{%
	\global\def\GZU@promise@date@year{#1}%
	\global\def\GZU@promise@date@month{#2}%
	\global\def\GZU@promise@date@day{#3}%
}
\newcommand{\promisenonconfidential}{%
	\GZU@promise@secretfalse
	\global\def\GZU@promise@secret@years{}%
}
\newcommand{\promiseconfidential}[1]{%
	\GZU@promise@secrettrue
	\global\def\GZU@promise@secret@years{#1}%
}
\newcommand{\promiseoriginalitysignatureposition}[2]{%
	\global\def\GZU@promise@orig@student@x{#1}%
	\global\def\GZU@promise@orig@student@y{#2}%
}
\newcommand{\promiseauthorizationstudentposition}[2]{%
	\global\def\GZU@promise@auth@student@x{#1}%
	\global\def\GZU@promise@auth@student@y{#2}%
}
\newcommand{\promiseauthorizationsupervisorposition}[2]{%
	\global\def\GZU@promise@auth@supervisor@x{#1}%
	\global\def\GZU@promise@auth@supervisor@y{#2}%
}
\pgfkeys{
	/GZU/promise/.is family,
	/GZU/promise,
	student-signature/.code={\global\def\GZU@promise@student@signature{#1}},
	supervisor-signature/.code={\global\def\GZU@promise@supervisor@signature{#1}},
	advisor-signature/.code={\global\def\GZU@promise@supervisor@signature{#1}},
	student-width/.store in=\GZU@promise@student@width,
	supervisor-width/.store in=\GZU@promise@supervisor@width,
	advisor-width/.store in=\GZU@promise@supervisor@width,
	date-year/.store in=\GZU@promise@date@year,
	date-month/.store in=\GZU@promise@date@month,
	date-day/.store in=\GZU@promise@date@day,
	secret-years/.store in=\GZU@promise@secret@years,
	confidential/.is choice,
	confidential/true/.code={\GZU@promise@secrettrue},
	confidential/false/.code={\GZU@promise@secretfalse},
	originality-student-x/.store in=\GZU@promise@orig@student@x,
	originality-student-y/.store in=\GZU@promise@orig@student@y,
	authorization-student-x/.store in=\GZU@promise@auth@student@x,
	authorization-student-y/.store in=\GZU@promise@auth@student@y,
	authorization-supervisor-x/.store in=\GZU@promise@auth@supervisor@x,
	authorization-supervisor-y/.store in=\GZU@promise@auth@supervisor@y,
	originality-date-y/.store in=\GZU@promise@orig@date@y,
	authorization-date-y/.store in=\GZU@promise@auth@date@y,
}
\newcommand{\promisesetup}[1]{\pgfkeys{/GZU/promise,#1}}

%%%%%%%%%%%%%%%%%%%%%%%% 字体族加载与字体样式 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 强制取消黑体加粗
\ExplSyntaxOn

\cs_new_protected:Npn \GZU_disable_zhhei_bold:
  {
    % 读取当前 zhhei 的主字体名
    \prop_get:NnNTF \g__xeCJK_family_font_name_prop { zhhei } \l_tmpa_tl
      {
        % 读取当前 zhhei 的原始字体选项
        \prop_get:NnNF \g__xeCJK_family_font_options_prop { zhhei } \l_tmpb_tl
          { \tl_clear:N \l_tmpb_tl }

        % 如果原来已有选项，先补一个逗号
        \tl_if_blank:VF \l_tmpb_tl
          { \tl_put_right:Nn \l_tmpb_tl { , } }

        % 追加设置：关闭伪粗体，并让 BoldFont 指回当前黑体本身
        \tl_put_right:Ne \l_tmpb_tl
          {
            AutoFakeBold = false ,
            BoldFont = { \exp_not:V \l_tmpa_tl }
          }

        % 用当前字体名和修改后的选项重新定义 zhhei
        \use:e
          {
            \exp_not:N \setCJKfamilyfont { zhhei }
              [ \exp_not:V \l_tmpb_tl ]
              { \exp_not:V \l_tmpa_tl }
          }
      }
      {
        \PackageWarning{GZU}{CJK family `zhhei' is not defined}
      }
  }

\AtBeginDocument{\GZU_disable_zhhei_bold:}

\ExplSyntaxOff

%% Windows 中文字体文件名缓存。
\def\GZU@fontname@song{}
\def\GZU@fontname@kai{}
\def\GZU@fontname@hei{}
\def\GZU@fontname@fsong{}

%% 主题字体默认楷体；启用华文行楷后会重定义。
\newcommand{\GZU@font@review@topic}{\zihao{-0} \CJKfamily+{zhkai}}
%% 终稿学校名称字体默认楷体；启用华文行楷后会重定义。
\newcommand{\GZU@font@final@university}{\bfseries \fontsize{29bp}{35bp}\selectfont \CJKfamily+{zhkai} \ziju{0.2}}

%% 注册华文行楷字体族。加粗使用伪粗，避免查找不存在或不兼容的粗体文件。
\newcommand{\GZU@sethwxkfont}[1]{%
	\setCJKfamilyfont{hwxk}{#1}%
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

%% 读取 ctex/xeCJK 已定义的 CJK 字体族，作为 Windows 字体缺失时的后备。
\ExplSyntaxOn
\cs_new_protected:Npn \GZU_save_cjk_family_font:Nn #1#2
  {
    \prop_get:NnNTF \g__xeCJK_family_font_name_prop {#2} \l_tmpa_tl
      {
        \cs_gset:Npx #1 { \exp_not:V \l_tmpa_tl }
      }
      {
        \ClassWarning{GZUthesis}{CJK family `#2' is not defined}
      }
  }
\cs_new_eq:NN \GZU@savefamilyfont \GZU_save_cjk_family_font:Nn
\ExplSyntaxOff

%% 查找系统字体名或文件名；第 4 参数可传 CJK family 名称作为后备。
\newcommand{\GZU@findfont}[4]{%
	\IfFontExistsTF{#2}{%
		\global\def#1{#2}%
	}{%
		\IfFontExistsTF{#3}{%
			\global\def#1{#3}%
		}{%
			\if\relax\detokenize{#4}\relax
			\else
				\GZU@savefamilyfont#1{#4}%
			\fi
		}%
	}%
}

%% 检查并启用 Windows 常用中文字体；缺失的字体族保持 ctex 默认设置。
\newcommand{\GZU@usewindowsfont}{%
	\GZU@findfont{\GZU@fontname@song}{SimSun}{simsun.ttc}{zhsong}%
	\GZU@findfont{\GZU@fontname@fsong}{FangSong}{simfang.ttf}{zhfs}%
	\GZU@findfont{\GZU@fontname@hei}{SimHei}{simhei.ttf}{zhhei}%
	\GZU@findfont{\GZU@fontname@kai}{KaiTi}{simkai.ttf}{zhkai}%
  
	\setCJKmainfont[AutoFakeBold,ItalicFont={\GZU@fontname@kai},BoldItalicFont={\GZU@fontname@kai},BoldItalicFeatures={FakeBold}]{\GZU@fontname@song}%
  \setCJKsansfont[AutoFakeBold]{\GZU@fontname@hei}%
  \setCJKmonofont[AutoFakeBold]{\GZU@fontname@fsong}%
	\setCJKfamilyfont{zhsong}[AutoFakeBold,ItalicFont={\GZU@fontname@kai},BoldItalicFont={\GZU@fontname@kai},BoldItalicFeatures={FakeBold}]{\GZU@fontname@song}%
	\setCJKfamilyfont{zhhei}{\GZU@fontname@hei}%
	\setCJKfamilyfont{zhfs}{\GZU@fontname@fsong}%
  \setCJKfamilyfont{zhkai}[AutoFakeBold]{\GZU@fontname@kai}%

}

\ifwindows\GZU@hwxkcheck\GZU@tnracheck\else\iffullfont
		\GZU@usewindowsfont
	\fi\fi
\ifchecktnra\GZU@tnracheck\fi
\ifcheckhwxk\GZU@hwxkcheck\fi

%% 盲审题目字体：一号黑体
\newcommand{\GZU@font@review@title}{\zihao{1} \sffamily}
%% 盲审地址字体：黑体四号
\newcommand{\GZU@font@review@address}{ \sffamily \zihao{4} }
%% 盲审日期字体：黑体四号
\newcommand{\GZU@font@review@date}{ \sffamily \zihao{4}}

%% 终稿封面顶部信息字体：宋体五号
\newcommand{\GZU@font@final@faceno}{\rmfamily \zihao{5}}
\newcommand{\GZU@font@final@classfyno}{\GZU@font@final@faceno}
\newcommand{\GZU@font@final@udcno}{\GZU@font@final@faceno}
\newcommand{\GZU@font@final@paperno}{\GZU@font@final@faceno}
\newcommand{\GZU@font@final@seclvl}{\GZU@font@final@faceno}
%% 终稿标题字体：20bp
\newcommand{\GZU@font@final@title}{\fontsize{20bp}{24bp}\selectfont }
%% 终稿地址字体：黑体 14bp
\newcommand{\GZU@font@final@address}{\sffamily \fontsize{14bp}{17bp}\selectfont  }
%% 终稿日期字体：黑体 14bp
\newcommand{\GZU@font@final@date}{\sffamily \fontsize{14bp}{17bp}\selectfont }

%% 终稿论文类型字体：宋体伪粗 20bp
\newcommand{\GZU@font@final@topic}{\rmfamily \bfseries\fontsize{20bp}{24bp}\selectfont \addfontfeatures{LetterSpace=10}\ziju{0.5} }
\newcommand{\GZU@font@final@degreecategory}{
  \rmfamily \bfseries\fontsize{16.5bp}{20bp} \selectfont%
}

%% 终稿封面表格字体：宋体 14bp
\newcommand{\GZU@font@final@table}{ \rmfamily \fontsize{14bp}{17bp}\selectfont }

%% 摘要标题字体：黑体/无衬线 小二
\newcommand{\GZU@font@abstitle}{\zihao{-2} \sffamily}
%% 盲审封面表格字体：三号黑体
\newcommand{\GZU@font@review@table}{ \sffamily \zihao{3} }
%% 摘要内容字体：宋体四号
\newcommand{\GZU@font@abscontent}{\rmfamily \zihao{4}}
%% 关键词标题字体：宋体四号加粗
\newcommand{\GZU@font@keywstitle}{\rmfamily  \zihao{4}}
%% 关键词正文字体：宋体四号
\newcommand{\GZU@font@keywscontent}{\rmfamily \zihao{4}}

%% 答辩信息页字体
\newcommand{\GZU@font@defense@topic}{\sffamily \zihao{2}}
\newcommand{\GZU@font@defense@title}{\sffamily \zihao{-2}}
\newcommand{\GZU@font@defense@main}{\rmfamily \fontsize{14bp}{17bp}\selectfont}

%% 致谢、图表与参考文字体。
\newcommand{\GZU@font@acknowledgments@title}{\zihao{5}\sffamily}
\newcommand{\acknowledgmentscontentfont}{\itshape}
\newcommand{\GZU@font@smallfivesong}{\zihao{-5}\rmfamily}
\newcommand{\GZU@font@smallfivehei}{\zihao{-5}\sffamily}
\newcommand{\GZU@font@bibliography@title}{\zihao{-4}\sffamily}
\newcommand{\GZU@font@bibliography@content}{\zihao{-5}\rmfamily}

%%%%%%%%%%%%%%%%%%%%%%%% 可选功能控制 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 空白页水印：仅在启用 watermark 选项后改写 \cleardoublepage。
\ifenablewatermark
	\RequirePackage[final]{draftwatermark}
	\RequirePackage{xcolor}
	\RequirePackage{graphicx}

	%% 空白页水印控制参数。
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

	%% shipout/background 的坐标原点在页面左上角，适合放背景内容。
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

	%% 双面打印补空白页时添加“此页无正文”水印。
	\renewcommand{\cleardoublepage}{%
		\clearpage
		\if@twoside
			\ifodd\c@page
				% 无需补空白页。
			\else
				% 需要补空白页：仅这一页加背景水印。
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

	%% 单面模式下不会产生双面补空白页，给出提醒。
	\AtBeginDocument{%
		\if@twoside\else
			\ClassWarning{GZUthesis}{%
				Watermark option enabled, but blank-page watermark\MessageBreak
				only takes effect in twoside mode%
			}%
		\fi
	}
\fi




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
  \setstretch{1.5}%
  \begin{center}
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

%% 根据论文类型设置封面主题并制作题名页。
\newcommand\GZU@setup@topics{%
	\ifGZU@topics@ready
	\else
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
		\global\GZU@topics@readytrue
	\fi
}

\newcommand\GZU@mktitle{%
	\GZU@setup@topics
	\GZU@mkpage@gradtitle
}

%% 制作研究生题名页。
\newcommand\GZU@mkpage@gradtitle{%
	\GZU@geometry@cover
	\ifreview    \GZU@mkpage@gradreview\fi

	\iffinal\GZU@mkpage@gradfinal\GZU@mkpage@defenseauto\makepromisepage\fi

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

%% 制作答辩信息页；若设置了 \defensepdf，则直接插入签字扫描件。
\newcommand\GZU@mkpage@defenseauto{%
	\ifx\GZU@defense@pdf\@empty
		\GZU@mkpage@defense
	\else
		\GZU@mkpage@defensepdf
	\fi
}
\newcommand\GZU@mkpage@defensepdf{%
	\includepdf[pages=1,fitpaper=true,pagecommand={\thispagestyle{empty}}]{\GZU@defense@pdf}%
}
\newcommand\GZU@mkpage@defense{%
	\thispagestyle{empty}

	~\vskip 60pt

	\noindent\centerline{\GZU@font@defense@topic\GZU@defense@topic}

	\vspace{55pt}
	\noindent
	\begin{center}
		\begin{minipage}[c][8\ccwd][t]{\GZU@titlewidth}
			\begin{center}
				\noindent\GZU@font@defense@title  \GZU@title
			\end{center}
		\end{minipage}
	\end{center}
	\vskip 70pt

	\hskip 40pt
	\begin{minipage}{.8\linewidth}
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
			\begin{tabular}[t]{@{}l@{\hspace{3em}}l@{\hspace{2em}}l@{\hspace{1em}}l@{}}
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
\newcommand{\makedefensepage}{%
	\GZU@setup@topics
	\GZU@geometry@cover
	\GZU@mkpage@defenseauto
	\restoregeometry
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
\newcommand{\GZU@promise@studentsignature}{%
	\ifx\GZU@promise@student@signature\@empty
	\else
		\includegraphics[width=\GZU@promise@student@width]{\GZU@promise@student@signature}%
	\fi
}
\newcommand{\GZU@promise@supervisorsignature}{%
	\ifx\GZU@promise@supervisor@signature\@empty
	\else
		\includegraphics[width=\GZU@promise@supervisor@width]{\GZU@promise@supervisor@signature}%
	\fi
}
\newcommand{\GZU@promise@date}[1]{%
	\node[anchor=base,fill=white,inner sep=0.5pt] at ([xshift=13.15cm,yshift=#1]current page.south west)
		{\GZU@promise@date@year};
	\node[anchor=base,fill=white,inner sep=0.5pt] at ([xshift=14.85cm,yshift=#1]current page.south west)
		{\GZU@promise@date@month};
	\node[anchor=base,fill=white,inner sep=0.5pt] at ([xshift=16.25cm,yshift=#1]current page.south west)
		{\GZU@promise@date@day};
}
\newcommand{\GZU@mkpage@promise}{%
	\thispagestyle{empty}%
	\begin{tikzpicture}[remember picture,overlay]
		\node[anchor=south west,inner sep=0pt] at (current page.south west)
			{\includegraphics[width=\paperwidth,height=\paperheight]{logo/promise-normalized.pdf}};

		\node[anchor=center] at ([xshift=\GZU@promise@orig@student@x,yshift=\GZU@promise@orig@student@y]current page.south west)
			{\GZU@promise@studentsignature};
		\GZU@promise@date{\GZU@promise@orig@date@y}

		\ifGZU@promise@secret
			\node[anchor=base] at ([xshift=6.48cm,yshift=8.50cm]current page.south west)
				{\Large $\sqrt{}$};
			\node[anchor=base,fill=white,inner sep=0.5pt] at ([xshift=9.52cm,yshift=8.50cm]current page.south west)
				{\GZU@promise@secret@years};
		\else
			\node[anchor=base] at ([xshift=6.48cm,yshift=7.72cm]current page.south west)
				{\Large $\sqrt{}$};
		\fi

		\node[anchor=center] at ([xshift=\GZU@promise@auth@student@x,yshift=\GZU@promise@auth@student@y]current page.south west)
			{\GZU@promise@studentsignature};
		\node[anchor=base] at ([xshift=\GZU@promise@auth@supervisor@x,yshift=\GZU@promise@auth@supervisor@y]current page.south west)
			{\GZU@promise@supervisorsignature};
		\GZU@promise@date{\GZU@promise@auth@date@y}
	\end{tikzpicture}%
	\null
	\clearpage
}
\newcommand{\GZU@includepromise}{%
	\fillblankpage
	\GZU@mkpage@promise
}
\newcommand{\makepromisepage}{\iffinal\ifgrad\GZU@includepromise\fi\fi}
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
\newenvironment{acknowledgments}[1][致谢]{%
	\clearpage{}
	{\centerline{\GZU@font@acknowledgments@title #1}}
	\vskip 8pt
	\addcontentsline{toc}{chapter}{#1}
	\markboth{#1}{#1}

	\par\acknowledgmentscontentfont
}{%
	\par
}

%% 图表、参考文献与表格正文字体绑定。
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
		format=\large\centering\sffamily,
		fixskip=true,
		beforeskip=0pt,
		afterskip=20pt,
	},
	section={
		fixskip=true,
		beforeskip=16pt,
		afterskip=16pt,
		format=\normalsize\sffamily,
	},
	subsection={
		fixskip=true,
		beforeskip=12pt,
		afterskip=12pt,
		format=\normalsize\sffamily,
	},
  subsubsection={
		fixskip=true,
		beforeskip=12pt,
		afterskip=12pt,
		format=\normalsize\sffamily,
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
	\item[\sffamily\normalsize\pgfkeysvalueof{/nomgroups/#1}]%
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
