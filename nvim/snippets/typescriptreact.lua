local luasnip = require('luasnip')
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local create_snippet = luasnip.s
local insert_node = luasnip.i
local text_node = luasnip.t
local function_node = luasnip.function_node

-- extends typescript snippets to typescriptreact filetypes
luasnip.filetype_extend("typescriptreact", { "typescript" })

-- helpers
local function capitalize(str)
  return str:gsub("^%l", string.upper)
end

local s, as = {}, {}

-- react snippets
s.use_state = create_snippet(
  "us",
  fmt(
    [[
        const [{}, {}] = useState({});
    ]],
    {
      insert_node(1, "state"),
      function_node(function(arg)
        local capitalized_input = capitalize(arg[1][1])
        return "set" .. capitalized_input
      end, { 1 }),
      insert_node(2),
    }
  )
)

s.use_state_with_type = create_snippet(
  "ust",
  fmt(
    [[
      const [{}, {}] = useState<{}>({});
    ]],
    {
      insert_node(1, "state"),
      function_node(function(arg)
        local capitalized_input = capitalize(arg[1][1])
        return "set" .. capitalized_input
      end, { 1 }),
      insert_node(2),
      insert_node(3),
    }
  )
)

s.use_effect = create_snippet(
  "ue",
  fmt(
    [[
      useEffect(() => {{
        {}
      }}, [{}])
    ]],
    {
      insert_node(1, "// TODO: do something here"),
      insert_node(2)
    }
  )
)

s.use_effect_with_return = create_snippet(
  "uer",
  fmt(
    [[
      useEffect(() => {{
        {}

        return () => {{
          {}
        }}
      }}, [{}])
    ]],
    {
      insert_node(1, "// TODO: do something here"),
      insert_node(2, "// TODO: do something here"),
      insert_node(3)
    }
  )
)

s.use_layout_effect = create_snippet(
  "ule",
  fmt(
    [[
      useLayoutEffect(() => {{
        {}
      }}, [{}])
    ]],
    {
      insert_node(1, "// TODO: do something here"),
      insert_node(2)
    }
  )
)

s.use_layout_effect_with_return = create_snippet(
  "uler",
  fmt(
    [[
      useLayoutEffect(() => {{
        {}

        return () => {{
          {}
        }}
      }}, [{}])
    ]],
    {
      insert_node(1, "// TODO: do something here"),
      insert_node(2, "// TODO: do something here"),
      insert_node(3)
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
