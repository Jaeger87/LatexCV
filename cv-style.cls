% -- Encoding UTF-8 without BOM

\ProvidesClass{cv-style}[2015/02/27 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{espanol}{\def\@cv@espanol{}}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}


%----------------------------------------------------------------------------------------
% Colors %
%----------------------------------------------------------------------------------------

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{blue}{HTML}{66D9EE}
\definecolor{red}{HTML}{FA2772}
\definecolor{orange}{HTML}{FE9720}
\definecolor{green}{HTML}{A7E22E}
\definecolor{purple}{HTML}{9358FE}
\definecolor{aquamarine}{HTML}{36AF90}

\definecolor{date}{HTML}{A4A4A4}

\ifdefined\@cv@print
  \colorlet{blue}{gray}
  \colorlet{red}{gray}
  \colorlet{orange}{gray}
  \colorlet{green}{gray}
  \colorlet{purple}{gray}
  \colorlet{aquamarine}{gray}
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}






%----------------------------------------------------------------------------------------
% Fonts %
%----------------------------------------------------------------------------------------

\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX,vargreek-shape=unicode]{unicode-math}


\newfontfamily\bodyfont{SourceSansPro-Regular}[Path=fonts/]
\newfontfamily\bodyfontit{SourceSansPro-LightItalic}[Path=fonts/]
\newfontfamily\thinfont{SourceSansPro-ExtraLight}[Path=fonts/]
\newfontfamily\headingfont{SourceSansPro-Black}[Path=fonts/]

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor, Path = fonts/]{SourceSansPro-Light}

%
%\newfontfamily\bodyfont{Roboto-Regular}[Path=fonts/]
%\newfontfamily\bodyfontit{Roboto-LightItalic}[Path=fonts/]
%\newfontfamily\thinfont{Roboto-Thin}[Path=fonts/]
%\newfontfamily\headingfont{RobotoCondensed-Bold}[Path=fonts/]
%
%\defaultfontfeatures{Mapping=tex-text}
%\setmainfont[Mapping=tex-text, Color=textcolor, Path = fonts/]{Roboto-Light}

\newcommand{\italica}[1]{%
    {\color{gray}\bodyfontit #1}%
}

%%%%%%%%%
% Icons %
%%%%%%%%%
\usepackage{fontawesome}
%----------------------------------------------------------------------------------------
% Header %
%----------------------------------------------------------------------------------------

\RequirePackage{tikz}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=3.7cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\thinfont #1}{\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{1.85cm}
  \vspace{-2\parskip}
}

%----------------------------------------------------------------------------------------
%	Last updated command %
%----------------------------------------------------------------------------------------

\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{polyglossia}

\newcommand{\sethyphenation}[3][]{%
  \sbox0{\begin{otherlanguage}[#1]{#2}
    \hyphenation{#3}\end{otherlanguage}}}
%\sethyphenation[<options>]{<language>}{<list of words separated by spaces>}

\ifdefined\@cv@espanol
  \setdefaultlanguage{spanish}
  \def\lastupdatedtext{Última Actualización el}
\else
  \setdefaultlanguage[variant=british]{english}
  \def\lastupdatedtext{Last Updated on}
\fi

\setlength{\TPHorizModule}{0.01\paperwidth}
\setlength{\TPVertModule}{0.01\paperwidth}

\newcommand{\lastupdated}{ 
  \begin{textblock}{10}(11.3, 0.05)
    \raggedleft
    \fontsize{8pt}{10pt}\color{date}\thinfont 
    \lastupdatedtext{} \today
  \end{textblock}}

%----------------------------------------------------------------------------------------
% Structure %
%----------------------------------------------------------------------------------------
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
        blue\or%
        red\or%
        orange\or%
        green\or%
        purple\or%
        aquamarine\else%
        headercolor\fi%
    } #1#2#3%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  {\par\vspace{.35\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{.15\parskip}}
}

\renewcommand{\subsection}[2]{
  \par\vspace{.22\parskip}%
  \Large\headingfont\color{headercolor} #2%
  \par\vspace{.11\parskip}%
}

\newcommand{\jobtitle}[1]{%
    {\color{gray}\bodyfontit #1}%
}

\pagestyle{empty}

%----------------------------------------------------------------------------------------
% List environment % ogni entry nel documento
%----------------------------------------------------------------------------------------

\usepackage{tabularx}
\usepackage{ltablex}
\usepackage{etoolbox}

\patchcmd{\TX@endtabularx}{\par}{}{}{}
\patchcmd{\TX@endtabularx}{\par}{}{}{}

\patchcmd{\TX@endtabularx}
{\end{tabularx}}
{\endtabularx\endgroup}
{}{}

\newcommand\tab[1][1cm]{\hspace*{#1}}
\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}
{  \tabularx{\textwidth}{@{\extracolsep{\fill} }    c  c  c  r }}
{ \endtabularx}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
  \parbox[t]{2.1cm}{#1}&\parbox[t]{12cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{.60\parsep}%
  }\\}

%----------------------------------------------------------------------------------------
% Side block  Blocco info contatto%
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{4.9}(0.5, 3.52)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

%----------------------------------------------------------------------------------------
% Other tweaks %
%----------------------------------------------------------------------------------------

\RequirePackage[left=5.9cm,top=1.94cm,right=1.5cm,bottom=1cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\hypersetup{
    pdftitle=CV/Resume \textbar{} Alejandro Pérez Londoño,
    pdfauthor=Alejandro Pérez Londoño,
    pdfsubject=CV/Resume%
    }