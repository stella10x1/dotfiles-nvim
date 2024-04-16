local snippets = {
  s("online", {
    t"@online{", i(1, "label"), t",",
    t({"","\ttitle = {"}), i(2, "title"), t"},",
    t({"","\turl = {"}), i(3, "url"), t"},",
    t({"","\turldate = {"}), i(4, "urldate"), t"},",
    t({"","\tdate = {"}), i(5, "date"), t"},",
    t({"","\tlangid = {"}), i(6, "english"), t"},",
    t({"","}"})
  }),
}

return snippets
