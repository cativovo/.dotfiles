local luasnip = require('luasnip')
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep
local lambda = extras.lambda
local dynamic_lambda = extras.dynamic_lambda

local create_snippet = luasnip.s
local insert_node = luasnip.i
local dynamic_node = luasnip.dynamic_node
local text_node = luasnip.t
local function_node = luasnip.function_node

-- extends typescript snippets to typescriptreact filetypes
luasnip.filetype_extend("typescriptreact", { "typescript" })

-- helpers
local function capitalize(str)
  return str:gsub("^%l", string.upper)
end

local function trim(str)
  return str:gsub("%s+", "")
end

local function remove_extension(str)
  return str:match("([^.]+)")
end

local s, as = {}, {}

-- TODO: add auto import if the package is not yet imported

-- hooks
s.use_state = create_snippet(
  "us",
  fmt(
    [[
        const [{}, {}] = useState({})
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
      const [{}, {}] = useState<{}>({})
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

s.use_memo = create_snippet("um", fmt(
  [[
    const {} = useMemo(() => {{
      return {}
    }}, [{}]) 
  ]],
  {
    insert_node(1),
    insert_node(2),
    insert_node(3),
  }
))

s.use_callback = create_snippet("uc", fmt(
  [[
    const {} = useCallback(({}) => {{
      {}
    }}, [{}]) 
  ]],
  {
    insert_node(1),
    insert_node(2),
    insert_node(3, '// TODO: do something here'),
    insert_node(4),
  }
))

s.use_ref = create_snippet("ur", fmt(
  [[
    const {} = useRef({})
  ]],
  {
    insert_node(1, "ref"),
    insert_node(2),
  }
))

s.use_ref_with_type = create_snippet("urt", fmt(
  [[
    const {} = useRef<{}>({})
  ]],
  {
    insert_node(1, "ref"),
    insert_node(2),
    insert_node(3),
  }
))

-- components
s.react_functional_component = create_snippet(
  "rfc",
  fmt(
    [[
    const {} = ({}) => {{
        return (
          {}
        )
    }}

    export default {}
    ]],
    {
      dynamic_lambda(1, remove_extension(lambda.TM_FILENAME)),
      insert_node(2),
      insert_node(3),
      rep(1)
    }
  )
)

s.react_functional_component_with_props = create_snippet(
  "rfcp",
  fmt(
    [[
    import {{ FC }} from 'react';

    type {} = {{
      {}
    }}

    const {}:FC<{}> = ({{{}}}) => {{
        {}

        return (
          {}
        )
    }}

    export default {}
    ]],
    {
      lambda(lambda._1 .. 'Props', { 1 }),
      insert_node(2),
      dynamic_lambda(1, remove_extension(lambda.TM_FILENAME)),
      lambda(lambda._1 .. 'Props', { 1 }),
      function_node(function(args)
        local result = ""
        for _, value in ipairs(args[1]) do
          value = value or ""
          value = trim(value)
          value = value:match("([^:]+)") or ""
          result = result .. value

          if value ~= "" then
            result = result .. ", "
          end
        end

        return result
      end, { 2 }),
      insert_node(3),
      insert_node(4),
      rep(1)
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
