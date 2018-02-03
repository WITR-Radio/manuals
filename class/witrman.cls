\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{witrman}[2018/01/31 WITR Manual Formatting]

% We're re-using memoir under the hood
% This defines the document as a 14pt-size article on US letter paper that only
% uses one side of the page (don't shift it right and left like a book)
\LoadClass[14pt,letterpaper,article,oneside]{memoir}


%%%%%%%%%%%%%%%%%%%%%
% Required packages %
%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{graphicx}  % For images
\RequirePackage{fontspec}  % For Century Gothic and Bebas Neue
\RequirePackage{hyperref}  % For links
\RequirePackage{eso-pic}   % For page background images
\RequirePackage{textpos}   % For lining up the revision date on the cover page 
\RequirePackage{color}     % For colored text


\graphicspath{{./images}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Memoir layout constraints %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\settypeblocksize{620pt}{350pt}{*}
\setlrmargins{*}{*}{1}
\setulmargins{*}{*}{1.8}
\setheaderspaces{18pt}{*}{*}
\settrims{0pt}{0pt}
\setheadfoot{28pt}{28pt}
\checkandfixthelayout


%%%%%%%%%
% Fonts %
%%%%%%%%%

\defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
% We're perverting the standard LaTeX font definitions here, because the main
% font is supposed to be a serif font, but here both are sans-serif.  It's
% alright, though, we know what we're doing.
\setmainfont{Century Gothic}
\setsansfont{Bebas Neue}

% If you can't find a copy of Century Gothic, LaTeX has an open-source clone
% called URW Gothic.  Comment out the Century Gothic line above and uncomment
% these to use it:
%\RequirePackage{avant}
%\RequirePackage[T1]{fontenc}
%\renewcommand*\familydefault{\sfdefault}


%%%%%%%%%%
% Colors %
%%%%%%%%%%

% Blue color for the revision text on the cover page
\definecolor{revision-blue}{HTML}{1794BB}


%%%%%%%%%%%%
% Defaults %
%%%%%%%%%%%%

\date{NOT SET 20XX}
\title{A WITR MANUAL}

% Don't show all the subsections in the ToC
\setcounter{tocdepth}{0}


%%%%%%%%%%%%
% Commands %
%%%%%%%%%%%%

% Which image to put on the title page.  By default, use one that explains what
% the document author has misconfigured.
\newcommand\TitlepageGraphic{misconfig}

% Command to make the background for the title page
\newcommand\TitlepageBG{%
    \put(0,0){%
        \parbox[b][\paperheight]{\paperwidth}{%
            \vfill
            \centering
            \includegraphics[
                width=0.91\paperwidth,
                height=0.93\paperheight
            ]{\TitlepageGraphic}%
            \vfill
}}}

% Command to make the background of the Table of Contents page
\newcommand\TOCBG{%
    \put(0,0){%
        \parbox[b][\paperheight]{\paperwidth}{%
            \vfill
            \centering
            \includegraphics[
                width=0.91\paperwidth,
                height=0.93\paperheight
            ]{images/toc}%
            \vfill
}}}

% Command to make the background of the body pages
\newcommand\BodyBG{%
    \put(0,0){%
        \parbox[b][\paperheight]{\paperwidth}{%
            \vfill
            \centering
            \includegraphics[
                width=0.91\paperwidth,
                height=0.93\paperheight
            ]{images/body}
            \vfill
}}}

% New list item command that creates a bold name, followed by a colon, then a
% description
\newcommand{\bolditem}[2]{%
    \item \textbf{#1}: #2
}

% This is the same as the itemize environment, except it clears the paragraph
% spacing so that the line gaps aren't huge
\newenvironment{skinnyitemize}{%
    \vspace{-\parskip}
    \vspace{-\topsep}
    \begin{itemize}%
        \setlength{\itemsep}{0pt}%
        \setlength{\parskip}{0pt}%
        \setlength{\parsep}{0pt}%
}{
    \end{itemize}
}

% Same thing as above, but for enumerate
\newenvironment{skinnyenumerate}{%
    \vspace{-\parskip}
    \vspace{-\topsep}
    \begin{enumerate}%
        \setlength{\itemsep}{0pt}%
        \setlength{\parskip}{0pt}%
        \setlength{\parsep}{0pt}%
}{
    \end{enumerate}
}

% Command to make the title page
\renewcommand{\maketitle}{%
\begin{titlingpage}
% Use a title page style that doesn't have a bunch of stuff already in it
\aliaspagestyle{titlingpage}{empty}

% Set the background for this page only
\AddToShipoutPictureBG*{\TitlepageBG} 

% Create a floating block that's 6.6cm wide, -0.65cm from the left margin, and
% 10cm from the top margin.
\begin{textblock*}{6.6cm}(-0.65cm,10cm)
{%
    % This makebox centers the text underneath "MANUAL". It's 3mm smaller than
    % the textblock box because it looks visually more centered. (The diagonal
    % line affects visual centering.)
    \makebox[6.3cm][c]{%
    % Some magic constants that set the font size for the date
    \fontsize{1.1cm}{1.4cm}\selectfont \color{revision-blue} \thedate%
}}
\end{textblock*}
\end{titlingpage}
}

% Command to make the table of contents page
\newcommand{\maketoc}{%
% Set the background for this page only
\AddToShipoutPictureBG*{\TOCBG}

% This mbox is to make sure that the vspace doesn't get ignored. LaTeX ignores
% spaces with no content before them.
\mbox{}
\vspace{3cm}
% Horizontally center the stuff in this environment
\begin{center}
    % Include WITR's logo at 2cm x 2cm
    \includegraphics[width=2cm,height=2cm]{witrlogo} \\
    % Make a horizontally centered, 3.6cm-wide paragraph box (supports line
    % breaks) that centers its contents.
    \parbox[c][3.6cm][c]{\textwidth}{%
        % The contents are supposed to be centered, but the text needs this
        % anyway.
        \centering
        \fontsize{2.7cm}{1.5cm}\selectfont \textsf{\thetitle}
    } 

    % include the date below the title. It's wrapped in brackets so that the
    % \Large macro doesn't spill out into the rest of the document.
    {\Large \thedate}
\end{center}

% the asterisk means that the ToC isn't added to itself
\tableofcontents* 

% Force a page break here
\pagebreak
}

% Set the regular page background
\newcommand{\setpagebg}{%
\AddToShipoutPictureBG{\BodyBG}
}

% Make the WITR logo footer
\newcommand{\makefooter}{%
% Skip half a centimeter down, for visual symmetry
\vspace{0.5cm}
% Center this box and put WITR's logo in it
\makebox[\textwidth][c]{
    \includegraphics[width=1.5cm,height=1.5cm]{images/witrlogo}
}
}


%%%%%%%%%%%%%%%%%%%%%%
% Paragraph Geometry %
%%%%%%%%%%%%%%%%%%%%%%

\hyphenpenalty=7500
\setlength{\parindent}{0cm}
\setlength{\parskip}{0.9em}

