\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{witrman}[2018/01/31 WITR Manual Formatting]

% We're re-using memoir under the hood
% This defines the document as a 14pt-size article on US letter paper that only
% uses one side of the page (don't shift it right and left like a book)
\LoadClass[14pt,letterpaper,article,oneside]{memoir}
%\LoadClass[14pt,letterpaper]{extreport}

\newcommand{\CoverGraphic}{images/cover-page}
\newcommand{\ToCGraphic}{images/toc-page}
\newcommand{\BodyGraphic}{images/body-page}
\newif\if@debuglayout\@debuglayoutfalse
\DeclareOption{debuglayout}{%
    \renewcommand{\ToCGraphic}{images/toc-transparent}%
    \renewcommand{\BodyGraphic}{images/body-transparent}%
    \@debuglayouttrue%
}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%
% Required packages %
%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{graphicx}  % For images
\RequirePackage{fontspec}  % For Century Gothic and Alternate Gothic No3 D
\RequirePackage[hidelinks]{hyperref}  % For links
\RequirePackage{eso-pic}   % For page background images
\RequirePackage{textpos}   % For the logo and text on the cover page
\RequirePackage{color}     % For colored text
\if@debuglayout
\RequirePackage[pass,showframe]{geometry}
\fi


\graphicspath{{./images}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Memoir layout constraints %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\settypeblocksize{580pt}{350pt}{*}
\setlrmargins{*}{*}{1}
\setulmargins{*}{*}{1.12}
\setheaderspaces{18pt}{*}{*}
\settrims{0pt}{0pt}
\setheadfoot{28pt}{28pt}
\checkandfixthelayout{}


%%%%%%%%%
% Fonts %
%%%%%%%%%

% The correct versions of all of these fonts are included in the repo for
% builds with TravisCI.  If you need to change them to compile the document on
% your local machine, you must change them back to the defaults before you
% commit and push to the repository, otherwise the build will fail!
\defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
\setmainfont{Century Gothic}
%\setmainfont{TeX Gyre Adventor}      % An acceptable alternate if you can't
                                      % find a copy of Century Gothic
\newfontfamily\logofont{Alternate Gothic No2 D}[LetterSpace=-2]
                                      % I'm fully aware that the style guide
                                      % says to use No3, but the title page
                                      % graphics were generated with No2, so I'm
                                      % using this for consistency's sake.
%\newfontfamily\logofont{Bebas Neue}  % An acceptable alternate if you can't
                                      % find a copy of Alternate Gothic No2 D


%%%%%%%%%%
% Colors %
%%%%%%%%%%

% WITR's color palette
\definecolor{witr-yellow}{HTML}{FAEA33}
\definecolor{witr-dark-yellow}{HTML}{F5D435}
\definecolor{witr-pale-blue}{HTML}{AADFF1}
\definecolor{witr-light-blue}{HTML}{69CDEE}
\definecolor{witr-blue}{HTML}{0EA5DF}
\definecolor{witr-dark-blue}{HTML}{1795BC}  % Use this for revision date


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

% Include a WITR logo. Specify a width as the first argument and one of
% "yellow", "white", or "black" as the second argument.
\newcommand\WITRLogo[2]{%
    \includegraphics[width=#1]{images/stacked-logo-#2}
}

% The color of the logo on the cover page
\newcommand\LogoColor{yellow}

% The color of the title on the cover page
\newcommand\TitleColor{white}

% Command to make the background for the title page
\newcommand\TitlepageBG{%
    \put(0,0){%
        \parbox[b][\paperheight]{\paperwidth}{%
            \vfill
            \centering
            \includegraphics[
                width=0.91\paperwidth,
                height=0.93\paperheight{}
            ]{\CoverGraphic}%
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
                height=0.93\paperheight{}
            ]{\ToCGraphic}%
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
                height=0.93\paperheight{}
            ]{\BodyGraphic}%
            \vfill
}}}

% New list item command that creates a bold name, followed by a colon, then a
% description
\newcommand{\bolditem}[2]{%
    \item \textbf{#1}: #2
}

% This is the same as the itemize environment, except it clears the paragraph
% spacing so that the line gaps aren't huge
\newenvironment{tightitemize}{%
    \begin{itemize}%
        \setlength{\itemsep}{0pt}%
        \setlength{\parskip}{0pt}%
        \setlength{\parsep}{0pt}%
}{
    \end{itemize}
}

% Same thing as above, but for enumerate
\newenvironment{tightenumerate}{%
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
    % Create a floating block that's 5 picas wide, -19.4 points from the left
    % margin, and -15.8 points from the top margin.
    \begin{textblock*}{5pc} (-19.4pt,-15.8pt)
        % Put the WITR logo in it
        \WITRLogo{79.5pt}{\LogoColor}
    \end{textblock*}

    % Create a floating block that's 19 picas wide, -22 points from the left
    % margin, and 90 ponts from the top margin.
    \begin{textblock*}{19pc} (-22pt,90pt)
        % Set the font to 88 points with a 66 point baseline skip, set the text
        % color to whatever the title color macro is, set the font to the logo
        % font, and then write out whatever the title is.
        \fontsize{88pt}{66pt}\selectfont {\color{\TitleColor}\logofont\thetitle}
    \end{textblock*}
    % Create a floating block that's 187 points wide, -0.66cm from the left
    % margin, and 9.6cm from the top margin.  These magic numbers line up the
    % text with the rest of the text on the front cover.
    \begin{textblock*}{187pt} (-0.66cm,8.1cm)
        % Choose a font size that is 25.5 points tall and has a baseline skip of
        % 34 points. Set the color to WITR's dark blue color.
        {\fontsize{25.5pt}{34pt}\selectfont\color{witr-dark-blue}\thedate}
    \end{textblock*}
\end{titlingpage}
}

% Command to make the table of contents page
\newcommand{\maketoc}{%
% Set the background for this page only
\AddToShipoutPictureBG*{\TOCBG}

% This mbox is to make sure that the vspace doesn't get ignored. LaTeX ignores
% spaces with no content before them.
%\mbox{}
%\vspace{1.5cm}
\begin{vplace}
    \centering
    \WITRLogo{2cm}{black}
\end{vplace}
% Horizontally center the stuff in this environment
\begin{center}
    %\vspace{1.5cm}
    {\fontsize{2.0cm}{2.0cm}\selectfont {\logofont\thetitle}}

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
\vspace{5mm}
% Center this box and put WITR's logo in it
\makebox[\textwidth][c]{%
    \WITRLogo{1.5cm}{black}
}
}


%%%%%%%%%%%%%%%%%%%%%%
% Paragraph Geometry %
%%%%%%%%%%%%%%%%%%%%%%

\hyphenpenalty=7500
\setlength{\parindent}{0cm}
\setlength{\parskip}{0.9em}

