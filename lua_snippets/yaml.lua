local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local isn = ls.indent_snippet_node

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

-- Composes the assertion in braces.
local function clamped_assertion(var_name, var_check)
  local braced_assertion = "(" .. var_name .. " " .. var_check .. ")"
  return braced_assertion
end

-- Creates one multi line item on the assert list.
local function assert_item(output, var_name, check_defined, check_none, var_type_check)
  table.insert(output, "- >")
  if check_defined ~= "" then
    table.insert(output, "  " .. clamped_assertion(var_name, check_defined) .. " or")
  end
  if check_none ~= "" then
    table.insert(output, "  " .. clamped_assertion(var_name, check_none) .. " or")
  end
  table.insert(output, "  " .. clamped_assertion(var_name, var_type_check))
end

-- Composes a multi statement assertion with 'or' conditions.
local function assertmulti(args)
  -- Map numbers to human readable var names.
  local var_name = args[1][1]
  local input_defined = args[2][1]
  local input_none = args[3][1]
  local var_type = args[4][1]

  -- Compose check statement for variable definition.
  local check_defined = "FAILED DEFINED CHECK"
  if input_defined == " is not defined or" then
    check_defined = "is not defined"
  else
    check_defined = ""
  end

  -- Compose check statement for none variable.
  local check_none = "FAILED NONE CHECK"
  if input_none == " is none or" then
    check_none = "is none"
  else
    check_none = ""
  end

  -- Define table for output. LuaSnip will make every table entry a new line.
  local output = {}

  -- When variable is not allowed to be none this is the first check.
  if check_none == "" then
    assert_item(output, var_name, check_defined, check_none, 'is not none')
  end

  if var_type == "list" then
    -- List is named 'iterable' in ansible
    assert_item(output, var_name, check_defined, check_none, 'is not string')
    assert_item(output, var_name, check_defined, check_none, 'is not mapping')
    assert_item(output, var_name, check_defined, check_none, 'is iterable')
  else
    -- All other data types are simpler and just need their type name to be checked.
    assert_item(output, var_name, check_defined, check_none, 'is ' .. var_type)
  end

  if var_type == "string" then
    -- A string should have at least one character
    assert_item(output, var_name, check_defined, check_none, '| length > 0')
  end

  return output
end

-- return the string "---" if the cursor is in the first line.
local function yamlbegin(args)
  local output = {}
  local cursorpos = vim.api.nvim_win_get_cursor(0)

  if cursorpos[1] == 1 then
    table.insert(output, "---")
    table.insert(output, "")
    return output
  end
end

local ansible_loop = function (args)
  return sn(nil, {
    t("loop: \"{{ "), i(1, "items"), t(" }}\""),
    t({"", "loop_control:"}),
    t({"", "  loop_var: "}), i(2, "item"),
    t({"", "  "}), c(3, {
        i(1),
        sn(nil, { t("label: \"{{ "), i(1, "item.name | default('N/A')"), t(" }}\"") })
    }),
  })
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

  s("assertmulti", {
    t"# ", i(1, "VARNAME"), c(2, {
      t" is not defined or",
      t"",
    }),
    c(3, {
      t" is none or",
      t"",
    }),
    t" is a ", c(4, {
      i(4, "TYPE"),
      t"string",
      t"boolean",
      t"number",
      t"list",
      t"mapping",
    }),
    t({"", ""}), f(assertmulti, {1, 2, 3, 4})
  }),

  s("assert", {
    t({"- name: "}), i(1, "Check something"),
    t({"", "  ansible.builtin.assert:"}),
    t({"", "    that:"}),
    t({"", "      "}), i(0),
    t({"", "    fail_msg: "}), i(2, "Check failed."),
    t({"", "    success_msg: "}), i(3, "All assertions passed."),
    t({"", "    quiet: "}), c(4, {
      t"true", t"false"
    })
  }),

  s("play", {
    f(yamlbegin),
    t({"- name: "}), i(1, "Configure"),
    t({"", "  hosts: "}), i(2, "localhost"),
    t({"", "  gather_facts: "}), c(3, {
      i(1, "true"),
      i(1, "false"),
    }),
    t({"", "  tasks:"}),
    c(4, {
      sn(nil, {
        t({"", "    - name: Include role "}), i(1, "NAME"),
        t({"", "      ansible.builtin.include_role:"}),
        t({"", "        name: "}), f(copy, 1),
      }),
      sn(nil, {
        t({"", "    - name: "}),
        i(1, "Configure / Print / Check"),
      }),
    }),
  }),

  s("task", {
    t({"- name: "}), i(1, "Do something"),
    t({"", "  "}), i(2, "module"), t({":"}),
    t({"", "    "}), i(0)
  }),

  s("include_vars", {
    t({"- name: \"Include OS specific variables for "}),
    i(1, "<role name>"), t"\"",
    t({"", "  ansible.builtin.include_vars:"}),
    t({"", "    file: \"{{ lookup('ansible.builtin.first_found', params) }}\""}),
    t({"", "  vars:"}),
    t({"", "    params:"}),
    t({"", "      files:"}),
    t({"", "        - \"{{ ansible_distribution }}-{{ ansible_distribution_major_version }}.yaml\""}),
    t({"", "        - \"{{ ansible_distribution }}.yaml\""}),
    t({"", "        - \"defaults.yaml\""}),
    t({"", "      paths:"}),
    t({"", "        - \"vars\""})
  }),

  s("loop", {
    d(1, ansible_loop)
  }),

  s("include_tasks", {
    t({"- name: \"Include tasks "}), c(2, {
    d(nil, function (args)
        local with_yaml = args[1][1] .. ".yaml"
        return sn(nil, {
          i(1), t({with_yaml})
        })
    end, {1}),
      i(nil, "custom text")
    }), t"\"",
    t({"", "  ansible.builtin.include_tasks:"}),
    t({"", "    file: "}),
    i(1, "tasks"), t".yaml",
    t({"", "  "}), c(3, {
      i(nil),
      isn(nil, {d(1, ansible_loop)}, "  ")
    }),
  }),

  s("include_role", {
    t({"- name: \"Include role "}), c(2, {
      f(copy, 1),
      i(nil, "custom text")
    }), t"\"",
    t({"", "  ansible.builtin.include_role:"}),
    t({"", "    file: "}),
    i(1, "role"),
    t({"", "  "}), c(3, {
      i(nil),
      isn(1, {d(1, ansible_loop)}, "  ")
    }),
  }),
}

return snippets
