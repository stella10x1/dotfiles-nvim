-- functions for snippets
local function copy(args)
	return args[1]
end

local function assertvar(args)
  local output = {}
  local linestart = '- ' .. args[1][1] .. ' '
  local datatype = args[2][1]

  if datatype == "list" then
    table.insert(output, linestart .. 'is not string')
    table.insert(output, linestart .. 'is not mapping')
    table.insert(output, linestart .. 'is iterable')
  else
    table.insert(output, linestart .. 'is ' .. datatype)
  end

  if datatype == "string" then
    table.insert(output, linestart .. '| length > 0')
  end

  return output
end

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

  s("assertvar", {
    t"# ", i(1, "VARNAME"), t" is a ", i(2, "TYPE"),
    t({"", "- "}), f(copy, 1), t" is defined",
    t({"", "- "}), f(copy, 1), t" is not none",
    t({"", ""}), f(assertvar, {1, 2})
  }),

  s("playbook", {
    t"---",
    t({"", "- name: "}), i(1, "Configure"),
    t({"", "  hosts: "}), i(2, "localhost"),
    t({"", "  tasks:"}),
    t({"", "    - name: "}), i(3, "Include role"),
    t({"", "      ansible.builtin.include_role:"}),
    t({"", "        name: "}), i(0, "rolename"),
  }),

  s("task", {
    t({"- name: "}), i(1, "Do something"),
    t({"", "  "}), i(2, "module"), t({":"}),
    t({"", "    "}), i(0)
  }),
}

return snippets
