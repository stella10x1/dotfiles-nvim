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
local r = ls.restore_node

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

local function d_argument_specs_types(_, _, _, user_arg1)
  -- user_arg1 is interpreted as scope. Currently supported scopes are:
  --
  --   * option_type
  --   * elements_type
  --
  local scope = user_arg1

  local argument_specs_types = {
    t("str"),
    t("list"),
    t("dict"),
    t("bool"),
    t("int"),
    t("float"),
    t("path"),
    t("raw"),
    t("jsonarg"),
    t("json"),
    t("bytes"),
    t("bits"),
  }

  if scope == "elements_type" then
    return sn(nil, {t({"","  elements: \""}), c(1, {
      r(nil, scope),
      unpack(argument_specs_types)
    }), t"\""})
  elseif scope == "option_type" then
    return sn(nil, c(1, {
      r(nil, scope),
      unpack(argument_specs_types)
    }))
  else
    return sn(nil, t"The user_arg1 defining the scope has wrong value. Correct your snippet.")
  end
end

local function comment_when(args, _, user_args1, user_args2)
  local comment_string = user_args1
  local comment_condition = user_args2

  if args[1][1] == comment_condition or args[1][1] == "" then
    return comment_string .. " "
  else
    return ""
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
    t({"", "    name: "}),
    i(1, "role"),
    t({"", "  "}), c(3, {
      i(nil),
      isn(1, {d(1, ansible_loop)}, "  ")
    }),
  }),

  s("argument_specs", {
    f(yamlbegin),
    t({"# argument specs file for " }), i(1, "NAME"),
    t({"", "", "argument_specs:" }),
    t({"", "  main:" }),
    t({"", "    short_description: \"Main entry point for " }), f(copy, 1), t" role\"",
    c(3, {
      d(nil, function (args)
        return sn(nil, {
          t({"", "    description:" }),
          t({"", "      - \"This is the main entrypoint for the " .. args[1][1] .. " role.\"" }),
          t({"", "      "}),
          f(comment_when, 1, { user_args = { "#", "Here we can describe what this entrypoint does in lengthy words." }}),
          t({"- \"" }),
          i(1, "Here we can describe what this entrypoint does in lengthy words."), t"\""
        })
      end, {1}),
      t"",
    }),
    t({"", "    author:" }),
    t({"", "      - \"" }), i(2, "AUTHOR"), t"\"",
    t({"", "    options:" }),
    t({"", "      " }), i(4),
    t({"", ""}),
    t({"", ""}),
    t({"# End of file" })
  }),

  s("opt", {
    i(1, "OPTION_NAME"), t":",
    t({"", "  type: \""}),
    d(2, d_argument_specs_types, {}, { user_args = { "option_type" } }), t"\"",
    d(3, function (args)
      if args[1][1] == "list" then
        return d_argument_specs_types(_, _, _, "elements_type")
      else
        return sn(nil, {t({""})})
      end
    end, {2}),
    t({"", ""}), c(4, {
      sn(nil, {t"  required: ", i(1, "true")}),
      sn(nil, {t"  default: ", i(1, "null")}),
    }),
    t({"", "  "}), f(comment_when, 5, { user_args = { "#", "Detailed explanation of what this option does." }}), t({"description:"}),
    t({"", "    "}), f(comment_when, 5, { user_args = { "#", "Detailed explanation of what this option does." }}), t({"- \""}), i(5, "Detailed explanation of what this option does."), t"\"",
    d(6, function (args)
      local list_elements = args[2][2]
      if list_elements then
        list_elements = list_elements:gsub("elements:", ""):gsub('"', ''):gsub("%s", "")
      end
      if args[1][1] == "dict" or list_elements == "dict" then
        return sn(nil, {t({"", "  options:"}), t({"","    "}), i(1)})
      else
        return sn(nil, {t({"", ""})})
      end
    end, {2, 3})
  }, {
      stored = {
        ["elements_type"] = i(nil, "TYPE"),
        ["option_type"] = i(nil, "TYPE"),
      }
    })
}

return snippets
