local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local snippets = {
  s("use", {
    t "use {",
    t { "", "\t'" },
    i(0, "package"),
    t { "'" },
    t { "", "}" },
  }),

  s("map", {
    t 'map("',
    i(1, "n"),
    t '", "',
    i(4, "MAPPING"),
    t '", ',
    i(0, '"ACTION"'),
    t ', { desc = "',
    i(2, "SECTION"),
    t " ",
    i(3, "DESC"),
    t '" })',
  }),

  s("nvconf", {
    t("-- "), i(1, "plugin"), t({" file for "}), i(2, "plugin name"), t".",
    t({"", ""}),
    t({"", ""}), i(0),
    t({"", ""}),
    t({"", "-- End of file."}),
  }),
}

return snippets
