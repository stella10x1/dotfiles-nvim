local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

-- functions for snippets
local function copy(args)
	return args[1]
end

local rec_ls
rec_ls = function()
	return sn(nil, {
		c(1, {
			-- important!! Having the sn(...) as the first choice will cause infinite recursion.
			t({""}),
			-- The same dynamicNode as in the snippet (also note: self reference).
			sn(nil, {t({"", "\t\\item "}), i(1), d(2, rec_ls, {})}),
		}),
	});
end

local snippets = {
  -- Section and Subsections
  s("sec", {
    t("\\section{"), i(1, "title"), t("}"),
    t({"", "\\label{sec:"}), f(copy, 1), t("}"),
    t({"",""}), t({"",""}), i(0)
  }),

  s("\\section", {
    t("\\section{"), i(1, "section"), t("}")
  }),

  s("sub", {
    t("\\subsection{"), i(1, sec), t("}"), 
    t({"", "\\label{sub:"}), f(copy, 1), t("}"), 
    t({"",""}), t({"",""}), i(0)
  }),

  s("\\subsection", {
    t("\\subsection{"), i(1, "subsection"), t("}")
  }),

  s("ssub", {
    t("\\subsubsection{"), i(1, sec), t("}"), 
    t({"", "\\label{ssub:"}), f(copy, 1), t("}"), 
    t({"",""}), 
    t({"",""}), i(0)
  }),

  s("\\subsection", {
    t("\\subsection{"), i(1, "subsection"), t("}")
  }),

  -- Enviroments
  s("begin", {
    t("\\begin{"), i(1, env), t("}"),
    t({"", "\t"}), i(0),
    t({"", "\\end{"}), f(copy, 1), t("}")
  }),

  s("enum", {
    t("\\begin{enumerate}"),
    t({"", "\t\\item "}), i(0),
    t({"", "\\end{enumerate}"})
  }),

  s("itemize", {
    t("\\begin{itemize}"),
    t({"", "\t\\item "}), i(0),
    t({"", "\\end{itemize}"})
  }),

  s("fig", {
    t("\\begin{figure}"),
    t({"", "\t\\includegraphics[width=\\textwidth]{"}), i(1), t({"}"}),
    t({"", "\t\\caption{"}), i(2), t("}"),
    t({"", "\t\\label{fig:"}), i(3), t("}"),
    t({"", "\\end{figure}"}),
    t({"",""}),
    t({"",""}), i(0)
  }),

  s("tab", {
    t("\\begin{table}["), i(1, "htbp!"), t("]"),
    t({"", "\t\\centering"}),
    t({"", "\t\\caption{"}), i(2), t("}"),
    t({"", "\t\\label{tab:"}), i(3), t("}"),
    t({"", "\t\\begin{tabular}{"}), i(4, "lrc"), t("}"),
    t({"", "\t\t"}), i(0),
    t({"", "\t\\end{tabular}"}),
    t({"", "\\end{table}"}),
    t({"",""}),
    t({"",""}),
  }),

  s("shelll", {
    t("\\begin{minted}[breaklines, linenos]{shell}"),
    t({"", ""}), i(0),
    t({"", "\\end{minted}"}),
    t({"",""})
  }),

  s("shell", {
    t("\\begin{minted}[breaklines]{shell}"),
    t({"", ""}), i(0),
    t({"", "\\end{minted}"}),
    t({"",""})
  }),

  s("center", {
    t("\\begin{center}"),
    t({"", "\t"}), i(0),
    t({"", "\\end{center}"})
  }),

  s("mintedl", {
    t("\\begin{minted}[breaklines, linenos]{"), i(1, "language"), t("}"),
    t({"", ""}), i(0),
    t({"", "\\end{minted}"}),
    t({"",""})
  }),

  s("minted", {
    t("\\begin{minted}[breaklines]{"), i(1, "language"), t("}"),
    t({"", ""}), i(0),
    t({"", "\\end{minted}"}),
    t({"",""})
  }),

  -- text
  s("bold", {
    t("\\textbf{"), i(1, "text"), t("}")
  }),

  s("italic", {
    t("\\textit{"), i(1, "text"), t("}")
  }),

  s("\\footnote", {
    t("\\footnote{"), i(1, "text"), t("}")
  }),

  s("\\href", {
    t("\\href{"), i(1, "URL"), t("}{"), i(2, "text"), t("}"), i(0)
  }),

  s("\\ref", {
    t("\\ref{"), i(1, "link"), t("}") 
  }),

  s("\\url", {
    t("\\url{"), i(1, "url"), t("}")
  }),

  s("\\furl", {
    t("\\footnote{\\url{"), i(1, "url"), t("}}")
  }),

  s("cites", {
    t("\\cite[S.~"), i(1, "Site"), t("]{"), i(2, "reference"), t("}"), i(0)
  }),

  s("cite", {
    t("\\cite{"), i(1, "reference"), t("}")
  }),

  s("verb", {
    t("\\verb|"), i(1, "code"), t("|"), i(0)
  }),

  s("gqq", {
    t("\\glqq "), i(1, "quote"), t("\\grqq~"), i(0)
  }),

  s("\\multicolumn", {
    t("\\multicolumn{"), i(1, "columns"), t("}{"), i(2, "align"), t("}{"), i(3, "text"), t("}"), i(0)
  }),

  s("\\multirow", {
    t("\\multirow{"), i(1, "rows"), t("}{"), i(2, "width"), t("}{"), i(3, "text"), t("}"), i(0)
  }),

  s("sieuro", {
    t("\\SI{"), i(1, "NUMBER"), t("}{\\sieuro}"), i(0)
  }),

  s("sipercent", {
    t("\\SI{"), i(1, "NUMBER"), t("}{\\percent}"), i(0)
  }),

  s("si", {
    t("\\SI{"), i(1, "NUMBER"), t("}{"), i(2, "UNIT"), t"}", i(0)
  }),

  -- acro
  s("acronyminit", {
    t("\\begin{acro}"),
    t({"", ""}), i(0),
    t({"", "\\end{acro}"}),
    t({"",""})
  }),

  s("acro", {
    t("\\acro{"), i(1, "short name"), t("}{"), i(2, "full name"), t("}"), i(0)
  }),

  s("ac", {
    t("\\ac{"), i(1, "Acronym"), t("}"), i(0)
  }),

  s("acf", {
    t("\\acf{"), i(1, "Acronym"), t("}"), i(0)
  }),

  s("acs", {
    t("\\acs{"), i(1, "Acronym"), t("}"), i(0)
  }),

  s("acp", {
    t("\\acp{"), i(1, "Acronym"), t("}"), i(0)
  }),

  s("acused", {
    t("\\acused{"), i(1, "Acronym"), t("}"), i(0)
  }),

  -- beamer
  s("frame", {
    -- t("\\begin{frame}{"), i(1, "name"), t("}"),
    t("\\begin{frame}"),
    c(1, {
      t(""),
      sn(nil, {t"[", i(1, "options"), t"]"})
    }),
    t({"", ""}),
    c(2, {
      -- sn(3, {t({"", "\t\\frametitle{"}), i(1, "title"), t("}")}),
      sn(nil, {t({"\t\\frametitle{"}), i(1, "title"), t("}"), t{"", ""}}),
      t(""),
    }),
    c(3, {
      sn(nil, {t("\t\\framesubtitle{"), i(1, "subtitle"), t("}"), t({"", ""})}),
      t(""),
    }),
    t("\t"), i(0),
    t({"", "\\end{frame}"}),
    t({"",""})
  }),

  -- tikz
  s("\\node", {
    t"\\node[", i(1, "options"), t"] (", i(2, "name"), t") {", i(0, "text"), t"};"
  }),

  s("\\coordinate", {
    t"\\coordinate[", i(1, "options"), t"] (", i(2, "name"), t");"
  }),

  s("\\draw", {
    t"\\draw",
    c(1, {
      sn(nil, {t"[", i(1, "{-Latex}"), t"]"}),
      t""
    }),
    t" (", i(2, "coord"), t") -- (", i(0, "coord"), t");"
  }),

  -- special functions
  s("ls", {
    t({"\\begin{itemize}",
    "\t\\item "}), i(1), d(2, rec_ls, {}),
    t({"", "\\end{itemize}"}), i(0)
  }),

  s("standalonetikz", {
    t"\\documentclass[tikz, border=1mm]{standalone}",
    t({"", ""}),
    t({"", "\\begin{document}"}),
    t({"", "\t\\begin{tikzpicture}"}),
    t({"", "\t\t"}), i(0),
    t({"", "\t\\end{tikzpicture}"}),
    t({"", "\\end{document}"})
  }),

  s("initscrartcl", {
    t"%! TeX program = lualatex",
    t({"", ""}),
    t({"", ""}),
    t"\\documentclass[paper=a4,fontsize=11pt]{scrartcl}",
    t({"", "\\usepackage[utf8]{inputenc}"}),
    t({"", "\\usepackage{fontspec}"}),
    t({"", "\\usepackage[ngerman]{babel}"}),
    t({"", "\\usepackage{graphicx}"}),
    t({"", "\\usepackage{xcolor} % needed for \\textcolor{color}{text}"}),
    t({"", ""}),
    t({"", "\\begin{document}"}),
    t({"", "\t"}), i(0),
    t({"", "\\end{document}"})
  }),

  s("newcommand", {
    t"\\newcommand{\\", i(1, "command"), t"}{", i(0, "do cool things"), t"}"
  }),

  s("setup:noindent", {
    t"\\setlength\\parindent{0pt}"
  }),

  s("abbrev", {
    t({"\\DeclareAcronym{"}), i(1, "key"), t"}{",
    t({"", "\tshort = {"}), i(2), t"},",
    t({"", "\tlong = {"}), i(3), t"},",
    t({"", "\ttag = {"}), i(0, "abbrev"), t"},",
    t({"", "}"})
  }),
}

return snippets
