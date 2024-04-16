local snippets = {
  s("code", {
    t"```", i(1, "language"),
    t({"",""}), i(0),
    t({"","```"})
  }),

  s("meta", {
    t"---", 
    t({"","title: "}), i(1, "title of the document"),
    t({"","lang: "}), c(2, {
      t("en"),
      t("de"),
    }),
    t({"","date: "}), i(3, os.date("%Y-%m-%d")),
    t({"","tags: "}),
    t({"","    - "}), i(4, "tag"),
    t({"","---"}),
    t({"",""}),
    t({"",""}), i(0),
  }),

  s("url", {
    t"[", i(1, "title"), t"](", i(2, "URL"), t")", i(0)
  }),

  s("wiki", {
    t"[[", i(1, "link"), t"|", i(2, "title"), t"]]", i(0)
  }),

  s("sup", {
    t"<sup>", i(1), t"</sup>", i(0)
  }),

  s("nsup", {
    i(1), t"<sup>", i(2), t"</sup>", i(0)
  }),

  s("sub", {
    t"<sub>", i(1), t"</sub>", i(0)
  }),

  s("nsub", {
    i(1), t"<sub>", i(2), t"</sub>", i(0)
  }),
}

return snippets
