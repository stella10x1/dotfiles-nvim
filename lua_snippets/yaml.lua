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
local fmta = require("luasnip.extras.fmt").fmta

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
    t({"", "  loop_var: "}), i(2, "item"), c(3, {
        i(1),
        sn(nil, {t({"", "  "}), t("label: \"{{ "), i(1, "item.name | default('N/A')"), t(" }}\"") })
    }),
  })
end

local function read_galaxy_yml(path)
  local galaxy_yml = io.open(path .. "/galaxy.yml", "r")
  if not galaxy_yml then return nil end

  local metadata = {}
  for line in galaxy_yml:lines() do
    local key, value = line:match("(%w+):%s*(.*)$")
    if key and value then
      value = value:gsub('^["\'](.-)["\']$', "%1")
      metadata[key] = value
    end
  end

  galaxy_yml:close()
  return metadata
end

local function split_path (path)
	local components = {}
	for component in path:gmatch("[^/]+") do
		table.insert(components, component)
	end
  return components
end

local function join_path (components)
  return "/" .. table.concat(components, "/")
end

local function get_ansible_role_name (path_components)
  -- Ansible Role Name
  local galaxy_yml_path = join_path({ unpack(path_components, 1, #path_components-4) })
  local galaxy_yml_data = read_galaxy_yml(galaxy_yml_path)

  local role_name_components = {}
  if galaxy_yml_data then
    if galaxy_yml_data.namespace and galaxy_yml_data.name then
      table.insert(role_name_components, galaxy_yml_data.namespace)
      table.insert(role_name_components, galaxy_yml_data.name)
    end
  elseif path_components[#path_components-6] == "ansible_collections" then
    table.insert(role_name_components, path_components[#path_components-5])
    table.insert(role_name_components, path_components[#path_components-4])
  end
  table.insert(role_name_components, path_components[#path_components-2])
  return table.concat(role_name_components, '.')
end

local function ansible_role_header (path_components)
  -- Ansible Role File Type
  local ansible_role_file_type = nil
  if path_components[#path_components] == "argument_specs.yaml" then
    ansible_role_file_type = "argument_specs"
  else
    ansible_role_file_type = path_components[#path_components-1]
  end

  local ansible_role_name = get_ansible_role_name(path_components)

  return sn(nil, {
    t("# " .. ansible_role_file_type .. " file for " .. ansible_role_name),
  })
end

local function ansible_host_vars_header (path_components)
  local host_name = path_components[#path_components-1]
  return sn(nil, {
    t("# ".. "host_vars file for " .. host_name)
  })
end

local function ansible_group_vars_header (path_components)
  local group_name = path_components[#path_components-1]
  return sn(nil, {
      t("# " .. "group_vars file for " .. group_name)
    })
end

local function ansible_file_header (args)
  local current_path_components = split_path(vim.api.nvim_buf_get_name(0))

  if current_path_components[#current_path_components-3] == "roles" then
    return ansible_role_header(current_path_components)
  elseif current_path_components[#current_path_components-2] == "host_vars" then
    return ansible_host_vars_header(current_path_components)
  elseif current_path_components[#current_path_components-2] == "group_vars" then
    return ansible_group_vars_header(current_path_components)
  else
    return sn(nil, {i(1)})
  end
end

local snippets = {

  s("ansiblerole", {
    f(yamlbegin),
    d(1, ansible_file_header),
    t({"", ""}),
    t({"", ""}), i(0),
  }),

  s("ansiblevars", {
    f(yamlbegin),
    d(1, ansible_file_header),
    t({"", ""}),
    c(2, {
      sn(nil, {
        t({"", "# ---------- Global Variables ----------"}),
        t({"", ""}),
        t({"", ""}), i(1),
      }),
      sn(nil, {
        i(1)
      }),
    }),
    c(3, {
      sn(nil, {
        t({"", "# ---------- Role Variables ----------"}),
        t({"", ""}),
        t({"", ""}), i(1),
      }),
      sn(nil, {
        i(1)
      }),
    }),
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
    t({"- name: \""}), i(1, "Check something"), t"\"",
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
    t({"- name: \""}), i(1, "Configure"), t"\"",
    t({"", "  hosts: "}),
      c(2,{
        i(nil, "localhost"),
        t"\"{{ target | default('all') }}\"",
      }),
    t({"", "  gather_facts: "}), c(3, {
      i(1, "true"),
      i(1, "false"),
    }),
    c(4, {
      sn(nil, {
        t({"", "  tags:"}),
        t({"", "    - "}), i(1, "tag_name"),
      }),
      t""
    }),
    t({"", "  tasks:"}),
    c(5, {
      sn(nil, {
        t({"", "    - name: \"Import role "}), i(1, "NAME"), t"\"",
        t({"", "      ansible.builtin.import_role:"}),
        t({"", "        name: "}), f(copy, 1),
      }),
      sn(nil, {
        t({"", "    - name: \"Include role "}), i(1, "NAME"), t"\"",
        t({"", "      ansible.builtin.include_role:"}),
        t({"", "        name: "}), f(copy, 1),
        t({"", "        apply: "}),
        t({"", "          tags: "}),
        t({"", "            - "}),
      }),
      sn(nil, {
        t({"", "    - name: \""}),
        i(1, "Configure / Print / Check"), t"\"",
      }),
    }),
  }),

  s("task", {
    t({"- name: \""}), i(1, "Do something"), t"\"",
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
        return sn(nil, {i(1)})
      end
    end, {2, 3})
  }, {
      stored = {
        ["elements_type"] = i(nil, "TYPE"),
        ["option_type"] = i(nil, "TYPE"),
      }
    }),

  s("set_fact", {
    t({"- name: \"Set fact "}), c(2, {
      f(copy, 1),
      i(nil, "custom text")
    }), t"\"",
    t({"", "  ansible.builtin.set_fact:"}),
    t({"", "    "}), i(1, "key"), t": ", i(3, "value"),
  }),

  s("validate_args", {
    t({"- name: \"Validate arguments "}), i(1, "for XYZ"), t"\"",
    t({"", "  ansible.builtin.validate_argument_spec:"}),
    t({"", "    argument_spec:"}),
    t({"", "      "}), f(copy, 2), t": \"{{ (lookup('ansible.builtin.file', 'meta/argument_specs.yaml')",
    t({"", "        | from_yaml)['argument_specs']['main']['options']['"}), i(2, "ARGUMENT"), t({"'] }}\""}),
    t({"", "    provided_arguments:"}),
    t({"", "      "}), f(copy, 2), t": \"{{ item.value }}\"",
    t({"", "  loop: \"{{ example_list }}\""}),
    t({"", "  loop_control:"}),
    t({"", "    loop_var: item"}),
    t({"", "    label: \"{{ item.name }}\""}),
    t({"", "  when:"}),
    t({"", "    - item.value is defined"}),
  }),

  s("template", {
    t({"- name: \""}), i(1, "Template X"), t"\"",
    t({"", "  ansible.builtin.template:"}),
    t({"", "    src: "}), i(2, "example.j2"),
    t({"", "    dest: "}), i(3, "/path/to/remote/location"),
    t({"", "    owner: "}), i(4, "root"),
    t({"", "    group: "}), i(5, "root"),
    t({"", "    mode: \""}), i(6, "0644"), t"\"", c(7, {
      isn(nil, {
        t({"", "become: true"}), i(1)
      }, "  "),
      isn(nil, {
        i(1)
      }, "  "),
    }),
  }),

  s("ansiblemeta", fmta([[
    dependencies: []

    galaxy_info:
      author: <author>
      description: <description>
      license: <license>

      min_ansible_version: "2.15"

      platforms: []
  ]], {
      author = i(1, "lingling"),
      description = i(2, "This role does something."),
      license = i(3, "The Unlicense")
    })),

  s("import_playbook", fmta([[
    - name: Import playbook <playbook_copy>
      ansible.builtin.import_playbook: <playbook>
  ]], {
      playbook = i(1, "NAMESPACE.COLLECTION.PLAYBOOK"),
      playbook_copy = f(copy, 1),
    })),
}

return snippets
