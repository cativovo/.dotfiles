local luasnip = require('luasnip')
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local create_snippet = luasnip.s
local insert_node = luasnip.i
local text_node = luasnip.t
local function_node = luasnip.function_node

-- helpers
local function capitalize(str)
  return str:gsub("^%l", string.upper)
end

local s, as = {}, {}

s.console_log = create_snippet(
  "clg",
  fmt(
    [[
        console.log({})
    ]],
    {
      insert_node(1, "'dito'"),
    }
  )
)

s.arrow_function = create_snippet(
  "af",
  fmt(
    [[
        const {} = ({}) => {}
    ]],
    {
      insert_node(1, "myFunction"),
      insert_node(2),
      insert_node(3),
    }
  )
)

s.arrow_function_with_return = create_snippet(
  "afr",
  fmt(
    [[
        const {} = ({}) => {{
          {}
          return {}
        }}
    ]],
    {
      insert_node(1, "myFunction"),
      insert_node(2),
      insert_node(3, "// TODO: do something here"),
      insert_node(4),
    }
  )
)


local snippets, autosnippets = {}, {}

for _, value in pairs(s) do
  table.insert(snippets, value)
end

for _, value in pairs(as) do
  table.insert(autosnippets, value)
end

return snippets, autosnippets
