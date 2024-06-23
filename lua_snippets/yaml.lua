local snippets = {

  s("ansiblerole", {
    t("---"),
    t({"", "# "}), i(1, "tasks"), t({" file for "}), i(2, "role name"),
    t({"", ""}),
    t({"", ""}), i(0),
    t({"", ""}),
    t({"", "# End of file"}),
  }),

  s("ansiblevars", {
    t("---"),
    t({"", "# "}),
    c(1, {
      sn(nil, {t("host vars for "), i(1, "HOST")}),
      sn(nil, {t("group vars for "), i(1, "GROUP")}),
    }),
    t({"", ""}),
    t({"", "# ---------- Global Variables ----------"}),
    t({"", ""}), i(2),
    t({"", ""}),
    t({"", "# ---------- Role Variables ----------"}),
    t({"", ""}), i(0),
    t({"", ""}),
    t({"", "# End of file"}),
  }),

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
