\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{in1150-innlevering}[2018/09/14 Innlevering for IN1150 -- Logiske metoder]
\LoadClass[12pt,norsk,a4paper]{article}

% Språk og tegn
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[norsk]{babel}
\RequirePackage{tikz}
\RequirePackage{booktabs}

% Fonter
\RequirePackage{tgpagella}
\RequirePackage[small,euler-digits]{eulervm}

% Lister
\RequirePackage{enumitem}
\newlist{deloppgaver}{enumerate}{1}
\setlist[deloppgaver]{label={\textbf{(\alph*)}},leftmargin=*}

% Matematikk
\RequirePackage{amsmath,amssymb}

% Noen nyttige forkortelser
\newcommand{\set}[1]{\ensuremath{\{#1\}}}
\newcommand{\tuple}[1]{\ensuremath{\langle #1 \rangle}}
\newcommand{\union}{\ensuremath{\cup}}
\newcommand{\snitt}{\ensuremath{\cap}}

\newcommand{\imp}{\ensuremath{\mathrel{\rightarrow}}}
\newcommand{\T}{\ensuremath{\mathbf{1}}}
\newcommand{\F}{\ensuremath{\mathbf{0}}}
\newcommand{\rem}[2]{\tikz[remember picture]\node[inner sep=0](#1){#2};}

% Venn Diagram

\tikzstyle{fargeA}=[fill=red,fill opacity=0.3]
\tikzstyle{fargeB}=[fill=blue,fill opacity=0.3]
\tikzstyle{fargeC}=[fill=green,fill opacity=0.3]

\def\mengdeA{(150:1) circle (1.4cm)}
\def\mengdeB{(30:1) circle (1.4cm)}
\def\mengdeC{(-90:1) circle (1.4cm)}

\newcommand{\dxA}{\draw\mengdeA;}
\newcommand{\dxB}{\draw\mengdeB;}
\newcommand{\dxC}{\draw\mengdeC;}

\newcommand{\fxA}{\fill\mengdeA [fargeA];}
\newcommand{\fxB}{\fill\mengdeB [fargeB];}
\newcommand{\fxC}{\fill\mengdeC [fargeC];}

\newcommand{\clA}{\clip\mengdeA;}
\newcommand{\clB}{\clip\mengdeB;}
\newcommand{\clAB}{\clip\mengdeA\mengdeB;}
\newcommand{\clABC}{\clip\mengdeA\mengdeB\mengdeC;}

\newcommand{\nota}[1]{\node[at={(0,3cm)}]{\ensuremath{#1}}}

\tikzstyle{mikro}=[baseline,scale=0.25,line width=0.5pt]
