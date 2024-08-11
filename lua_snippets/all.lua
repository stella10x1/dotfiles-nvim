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

local snippets = {
  s("--", {
    t("---------- "), i(1, "heading"), t(" ----------"),
  }),

  s("j2if", {
    t"{% if ", c(1, {
      sn(nil, {
        t"(", i(1, "VAR"), t" is defined) and (", f(copy, 1), t" is not none)"
      }),
      sn(nil, {
        i(1, "BOOLEAN-VAR")
      }),
      sn(nil, {
        t"(", i(1, "VAR"), t" is defined)"
      }),
      sn(nil, {
        t"(", i(1, "VAR"), t" is not none)"
      }),
    }), t" %}",
    c(2, {
      sn(nil, {
        t({"", ""}), i(1),
      }),
      sn(nil, {
        t({"", ""}), i(1),
        t({"", "{% else %}"}),
        t({"", ""}), i(2),
      }),
      sn(nil, {
        t({"", ""}),
        t({"", "{% elif "}), i(1), t" %}",
        t({"", ""}), i(2),
        t({"", "{% else %}"}),
        t({"", ""}), i(3),
      }),
    }),
    t({"","{% endif %}"}),
  })
}

return snippets
