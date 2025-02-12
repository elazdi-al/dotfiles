local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Snippet for including an image in a centered environment
  s("image", {
    t({ "\\begin{center}", "    \\includegraphics[width=0.45\\textwidth]{ " }),
    i(1, "image_path"),     -- Placeholder for the image path
    t({ " }", "\\end{center}" }),
  }),

  s("half", {
    t({ "\\begin{center}", "    \\begin{minipage}{0.45\\textwidth}", "        " }),
    i(1, "Left content"),
    t({ "", "    \\end{minipage} \\hfill", "    \\begin{minipage}{0.45\\textwidth}", "        " }),
    i(2, "Right content"),
    t({ "", "    \\end{minipage}", "\\end{center}" }),
  }),
}
