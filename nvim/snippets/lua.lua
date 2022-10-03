local luasnip = require('luasnip')
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local create_snippet = luasnip.s
local insert_node = luasnip.i
local text_node = luasnip.t
local function_node = luasnip.function_node


local s, as = {}, {}

s.pcall = create_snippet(
  "pc",
  fmt(
    [[
        local {}, {} = pcall(require, "{}")
    ]],
    {
      insert_node(2, "present"),
      function_node(function(arg)
        return arg[1][1]:gsub("%.", "_")
      end, { 1 }),
      insert_node(1),
    }
  )
)

s.my_function = create_snippet(
  "fc",
  fmt(
    [[
        local function {}({})
          {}
        end
    ]],
    {
      insert_node(1, "my_function"),
      insert_node(2, "args"),
      insert_node(3, "-- TODO: something")
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
