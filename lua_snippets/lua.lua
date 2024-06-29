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
}

return snippets
