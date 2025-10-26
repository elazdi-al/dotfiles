-- LaTeX snippets for fast input
-- Optimized for mathematical writing and document creation

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- Helper function for autosnippets with word boundary
local function autosnippet(trigger, nodes, opts)
  opts = opts or {}
  opts.wordTrig = opts.wordTrig == nil and true or opts.wordTrig
  return s({trig = trigger, snippetType = "autosnippet", wordTrig = opts.wordTrig}, nodes)
end

return {
  -- Document structure
  s("doc", fmta([[
    \documentclass{<>}

    \begin{document}

    <>

    \end{document}
  ]], { c(1, { t("article"), t("report"), t("book"), t("letter") }), i(0) })),

  s("beg", fmta([[
    \begin{<>}
      <>
    \end{<>}
  ]], { i(1), i(0), rep(1) })),

  -- Math environments
  s("eq", fmta([[
    \begin{equation}
      <>
    \end{equation}
  ]], { i(0) })),

  s("eql", fmta([[
    \begin{equation}
      \label{eq:<>}
      <>
    \end{equation}
  ]], { i(1), i(0) })),

  s("ali", fmta([[
    \begin{align}
      <>
    \end{align}
  ]], { i(0) })),

  s("alil", fmta([[
    \begin{align}
      <> &= <> \label{eq:<>} \\
      <>
    \end{align}
  ]], { i(1), i(2), i(3), i(0) })),

  -- Inline and display math
  s("mm", fmta([[$<>$]], { i(1) })),
  s("dm", fmta("\\[<>\\]", { i(1) })),

  -- Fractions (auto-expanding)
  autosnippet("//", fmta([[\frac{<>}{<>}]], { i(1), i(2) })),
  s("frac", fmta([[\frac{<>}{<>}]], { i(1), i(2) })),

  -- Subscripts and superscripts (auto-expanding)
  autosnippet("__", fmta([[_{<>}]], { i(1) })),
  autosnippet("^^", fmta([[^{<>}]], { i(1) })),
  autosnippet("sr", fmta([[^{<>}_{<>}]], { i(1), i(2) })),

  -- Greek letters (auto-expanding)
  autosnippet("alp", t("\\alpha")),
  autosnippet("bet", t("\\beta")),
  autosnippet("gam", t("\\gamma")),
  autosnippet("Gam", t("\\Gamma")),
  autosnippet("del", t("\\delta")),
  autosnippet("Del", t("\\Delta")),
  autosnippet("eps", t("\\epsilon")),
  autosnippet("zet", t("\\zeta")),
  autosnippet("eta", t("\\eta")),
  autosnippet("the", t("\\theta")),
  autosnippet("The", t("\\Theta")),
  autosnippet("kap", t("\\kappa")),
  autosnippet("lam", t("\\lambda")),
  autosnippet("Lam", t("\\Lambda")),
  autosnippet("sig", t("\\sigma")),
  autosnippet("Sig", t("\\Sigma")),
  autosnippet("ome", t("\\omega")),
  autosnippet("Ome", t("\\Omega")),
  autosnippet("ppi", t("\\pi")),
  autosnippet("rho", t("\\rho")),
  autosnippet("tau", t("\\tau")),
  autosnippet("phi", t("\\phi")),
  autosnippet("Phi", t("\\Phi")),
  autosnippet("chi", t("\\chi")),
  autosnippet("psi", t("\\psi")),
  autosnippet("Psi", t("\\Psi")),

  -- Common operators
  s("sum", fmta([[\sum_{<>}^{<>} <>]], { i(1, "i=1"), i(2, "n"), i(0) })),
  s("prod", fmta([[\prod_{<>}^{<>} <>]], { i(1, "i=1"), i(2, "n"), i(0) })),
  s("int", fmta([[\int_{<>}^{<>} <>]], { i(1, "a"), i(2, "b"), i(0) })),
  s("lim", fmta([[\lim_{<> \to <>} <>]], { i(1, "x"), i(2, "\\infty"), i(0) })),

  -- Parentheses/brackets (auto-expanding)
  autosnippet("lr(", fmta("\\left( <> \\right)", { i(1) })),
  autosnippet("lr[", fmta("\\left[ <> \\right]", { i(1) })),
  autosnippet("lr{", fmta("\\left\\{ <> \\right\\}", { i(1) })),
  autosnippet("lr|", fmta("\\left| <> \\right|", { i(1) })),

  -- Sections
  s("sec", fmta([[\section{<>}]], { i(1) })),
  s("ssec", fmta([[\subsection{<>}]], { i(1) })),
  s("sssec", fmta([[\subsubsection{<>}]], { i(1) })),

  -- Formatting
  s("bf", fmta([[\textbf{<>}]], { i(1) })),
  s("it", fmta([[\textit{<>}]], { i(1) })),
  s("tt", fmta([[\texttt{<>}]], { i(1) })),
  s("emph", fmta([[\emph{<>}]], { i(1) })),

  -- Lists
  s("item", fmta([[
    \begin{itemize}
      \item <>
    \end{itemize}
  ]], { i(0) })),

  s("enum", fmta([[
    \begin{enumerate}
      \item <>
    \end{enumerate}
  ]], { i(0) })),

  -- Figures
  s("fig", fmta([[
    \begin{figure}[<>]
      \centering
      \includegraphics[width=<>\textwidth]{<>}
      \caption{<>}
      \label{fig:<>}
    \end{figure}
  ]], { i(1, "htbp"), i(2, "0.8"), i(3, "path/to/image"), i(4, "Caption"), i(5, "label") })),

  -- Tables
  s("tab", fmta([[
    \begin{table}[<>]
      \centering
      \begin{tabular}{<>}
        \hline
        <> \\
        \hline
      \end{tabular}
      \caption{<>}
      \label{tab:<>}
    \end{table}
  ]], { i(1, "htbp"), i(2, "cc"), i(3), i(4, "Caption"), i(5, "label") })),

  -- Matrix environments
  s("mat", fmta([[
    \begin{<>matrix}
      <>
    \end{<>matrix}
  ]], { c(1, { t(""), t("p"), t("b"), t("v"), t("V"), t("B") }), i(0), rep(1) })),

  -- Cases
  s("cases", fmta([[
    \begin{cases}
      <> & <> \\
      <>
    \end{cases}
  ]], { i(1), i(2), i(0) })),

  -- Common symbols (auto-expanding)
  autosnippet("oo", t("\\infty")),
  autosnippet("inn", t("\\in")),
  autosnippet("notin", t("\\notin")),
  autosnippet("<<", t("\\ll")),
  autosnippet(">>", t("\\gg")),
  autosnippet("~~", t("\\sim")),
  autosnippet("...", t("\\ldots")),

  -- Arrows and relations
  autosnippet("->", t("\\to")),
  autosnippet("!>", t("\\mapsto")),
  autosnippet("<->", t("\\leftrightarrow")),
  autosnippet("=>", t("\\Rightarrow")),
  autosnippet("=<", t("\\Leftarrow")),
  autosnippet("<=>", t("\\Leftrightarrow")),
  autosnippet("!=", t("\\neq")),
  autosnippet("<=", t("\\leq")),
  autosnippet(">=", t("\\geq")),

  -- Operations
  autosnippet("xx", t("\\times")),
  autosnippet("cdot", t("\\cdot")),
  autosnippet("pm", t("\\pm")),
  autosnippet("mp", t("\\mp")),

  -- Sets (auto-expanding)
  autosnippet("NN", t("\\mathbb{N}")),
  autosnippet("ZZ", t("\\mathbb{Z}")),
  autosnippet("QQ", t("\\mathbb{Q}")),
  autosnippet("RR", t("\\mathbb{R}")),
  autosnippet("CC", t("\\mathbb{C}")),
  autosnippet("subset", t("\\subset")),
  autosnippet("supset", t("\\supset")),
  autosnippet("subseteq", t("\\subseteq")),
  autosnippet("supseteq", t("\\supseteq")),
  autosnippet("cup", t("\\cup")),
  autosnippet("cap", t("\\cap")),
  autosnippet("empty", t("\\emptyset")),

  -- Common math functions (auto-expanding)
  autosnippet("sin", t("\\sin")),
  autosnippet("cos", t("\\cos")),
  autosnippet("tan", t("\\tan")),
  autosnippet("ln", t("\\ln")),
  autosnippet("exp", t("\\exp")),
  s("log", t("\\log")), -- Not auto because "log" is a common word

  -- Derivatives (auto-expanding for fast input)
  autosnippet("dd", fmta([[\frac{d<>}{d<>}]], { i(1, "y"), i(2, "x") })),
  autosnippet("pd", fmta([[\frac{\partial <>}{\partial <>}]], { i(1, "y"), i(2, "x") })),

  -- Special characters (auto-expanding)
  autosnippet("ell", t("\\ell")),
  autosnippet("hbar", t("\\hbar")),
  autosnippet("nabla", t("\\nabla")),
  autosnippet("partial", t("\\partial")),
  autosnippet("EE", t("\\exists")),
  autosnippet("AA", t("\\forall")),

  -- Vectors and accents (auto-expanding)
  autosnippet("vec", fmta([[\vec{<>}]], { i(1) })),
  autosnippet("bar", fmta([[\bar{<>}]], { i(1) })),
  autosnippet("hat", fmta([[\hat{<>}]], { i(1) })),
  autosnippet("tilde", fmta([[\tilde{<>}]], { i(1) })),
  autosnippet("dot", fmta([[\dot{<>}]], { i(1) })),
  autosnippet("ddot", fmta([[\ddot{<>}]], { i(1) })),

  -- References
  s("ref", fmta([[\ref{<>}]], { i(1) })),
  s("eqref", fmta([[\eqref{<>}]], { i(1) })),
  s("cite", fmta([[\cite{<>}]], { i(1) })),
  s("label", fmta([[\label{<>}]], { i(1) })),
}
