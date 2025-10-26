-- Markdown snippets

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

return {
  -- Headers
  s("h1", fmt("# {}", { i(1) })),
  s("h2", fmt("## {}", { i(1) })),
  s("h3", fmt("### {}", { i(1) })),
  s("h4", fmt("#### {}", { i(1) })),

  -- Formatting
  s("bold", fmt("**{}**", { i(1) })),
  s("italic", fmt("*{}*", { i(1) })),
  s("code", fmt("`{}`", { i(1) })),

  -- Links and images
  s("link", fmt("[{}]({})", { i(1, "text"), i(2, "url") })),
  s("img", fmt("![{}]({})", { i(1, "alt"), i(2, "path") })),

  -- Code blocks
  s("code3", fmt([[
    ```{}
    {}
    ```
  ]], { i(1, "language"), i(2) })),

  -- Lists
  s("ul", fmt([[
    - {}
    - {}
  ]], { i(1), i(0) })),

  s("ol", fmt([[
    1. {}
    2. {}
  ]], { i(1), i(0) })),

  -- Checkbox
  s("check", t("- [ ] ")),
  s("checkx", t("- [x] ")),

  -- Horizontal rule
  s("hr", t("---")),

  -- Blockquote
  s("quote", fmt("> {}", { i(1) })),

  -- Table
  s("table", fmt([[
    | {} | {} |
    | --- | --- |
    | {} | {} |
  ]], { i(1, "Header1"), i(2, "Header2"), i(3), i(4) })),
}
