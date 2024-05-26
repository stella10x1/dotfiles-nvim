local snippets = {

  s("debug", {
    t("- name: \""), i(1, "Debug Task"), t("\""),
    t({"", "  ansible.builtin.debug:"}),
    c(2, {
      sn(nil, {t({"", "    msg: \""}), i(1, "Cool Output"), t("\"")}),
      sn(nil, {t({"", "    var: "}), i(1, "var_name"), t("")}),
    }),
  }),

  s("fail", {
    t("- name: \""), i(1, "Intentional fail"), t("\""),
    t({"", "  ansible.builtin.fail:"}),
    t({"", "    msg: \"Under development\""}),
    t({"", ""}), i(0),
  }),
}

return snippets
