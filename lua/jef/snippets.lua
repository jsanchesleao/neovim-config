-- examples found on https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L194

local ls = require('luasnip')

local s = ls.snippet
local c = ls.choice_node
local sn = ls.snippet_node
local t = ls.text_node
local r = ls.restore_node
local i = ls.insert_node
local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt

local function add(filetypes, snippets)
  for _, filetype in ipairs(filetypes) do
    ls.add_snippets(filetype, snippets)
  end
end

add({ "typescriptreact", "typescript" }, {
  -- if statement
  s("if", {
    t("if ("),
    i(1, "/* condition */"),
    t({ ") {", "\t" }),
    i(2, "// body"),
    t({ "", "}" }),
  }),

  s("$theme", {
    t("${({theme}) => "),
    i(1),
    t("};"),
  }),

  -- css shortcuts
  s("bgc", { t("background-color: "), i(0) }),

  -- styled component
  s("styled", fmt([[
    export const {name} = styled{base}`
    {final}
    `
  ]], {
    name = i(1, "StyledElement"),
    base = c(2, {
      sn(nil, {
        t("("), r(1, "Component", i(1)), t(")"),
      }),
      sn(nil, {
        t("."), r(1, "tag", i(1)),
      }),
    }),
    final = i(0),
  })),
})

add({ "typescriptreact" }, {
  -- jsx tag
  s("tag", fmt([[
   <{1} {2}>
      {3}
   </{4}>
  ]], {
    i(1, "div"),
    i(2, " "),
    i(0),
    rep(1),
  })),

  -- outline 2px (for testing)
  s("out", {
    t("style={{outline: '2px solid "),
    i(1, "purple"),
    t("'}}"),
  }),
})
