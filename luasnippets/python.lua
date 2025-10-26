-- Python snippets

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

return {
  -- Function definition
  s("def", fmt([[
    def {}({}):
        """{}"""
        {}
  ]], { i(1, "function_name"), i(2, "args"), i(3, "Docstring"), i(0) })),

  -- Class definition
  s("class", fmt([[
    class {}:
        """{}"""

        def __init__(self{}):
            {}
  ]], { i(1, "ClassName"), i(2, "Docstring"), i(3), i(0) })),

  -- If statement
  s("if", fmt([[
    if {}:
        {}
  ]], { i(1, "condition"), i(0) })),

  -- For loop
  s("for", fmt([[
    for {} in {}:
        {}
  ]], { i(1, "item"), i(2, "items"), i(0) })),

  -- While loop
  s("while", fmt([[
    while {}:
        {}
  ]], { i(1, "condition"), i(0) })),

  -- Try-except
  s("try", fmt([[
    try:
        {}
    except {}:
        {}
  ]], { i(1), i(2, "Exception"), i(0) })),

  -- Main guard
  s("main", fmt([[
    if __name__ == "__main__":
        {}
  ]], { i(0) })),

  -- Print
  s("print", fmt('print({})', { i(1) })),

  -- Import
  s("imp", fmt('import {}', { i(1) })),
  s("from", fmt('from {} import {}', { i(1), i(2) })),

  -- List comprehension
  s("lc", fmt('[{} for {} in {}]', { i(1), i(2, "item"), i(3, "items") })),

  -- Dict comprehension
  s("dc", fmt('{{{}: {} for {} in {}}}', { i(1, "k"), i(2, "v"), i(3, "item"), i(4, "items") })),

  -- Type hints
  s("tdef", fmt([[
    def {}({}) -> {}:
        {}
  ]], { i(1, "function"), i(2, "arg: type"), i(3, "ReturnType"), i(0) })),

  -- Dataclass
  s("dataclass", fmt([[
    from dataclasses import dataclass

    @dataclass
    class {}:
        {}: {}
  ]], { i(1, "ClassName"), i(2, "field"), i(3, "type") })),
}
