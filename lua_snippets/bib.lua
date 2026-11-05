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
  s("online", {
    t("@online{"),
    i(1, "label"),
    t(","),
    t({ "", "\ttitle = {" }),
    i(2, "title"),
    t("},"),
    t({ "", "\turl = {" }),
    i(3, "url"),
    t("},"),
    t({ "", "\turldate = {" }),
    i(4, "urldate"),
    t("},"),
    t({ "", "\tdate = {" }),
    i(5, "date"),
    t("},"),
    t({ "", "\tlangid = {" }),
    i(6, "english"),
    t("},"),
    t({ "", "}" }),
  }),
}

return snippets
