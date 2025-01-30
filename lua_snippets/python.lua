local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local function copy(args)
	return args[1]
end

local snippets = {
  s("argparse-init", {
    t("import argparse"),
    t({"","from sys import exit, stderr, argv"}),
    t({"",""}),
    t({"",""}),
    t({"","def commands():"}),
    t({"","\tparser = argparse.ArgumentParser("}),
    t({"","\t\tdescription='"}), i(1, "description"), t"')",
    t({"",""}),
    t({"","\t"}),
    c(2, {
      t({""}),
      sn(nil, {t"subparsers = parser.add_subparsers(",
        t({"","\t\ttitle='"}), i(1, "Subcommands"), t({"',"}),
        t({"","\t\tdescription='Search for help with SUBCOMMAND --help')"}),
        t({"",""}),
        t({"","\t"})
      }),
    }),
    i(0),
    t({"",""}),
    t({"","\t# prints help instead an exception when no arguments are given"}),
    t({"","\tif len(argv) == 1:"}),
    t({"","\t\tparser.print_help(stderr)"}),
    t({"","\t\texit(1)"}),
    t({"",""}),
    t({"","\targs = parser.parse_args()"}),
    t({"",""}),
    t({"","\treturn args"})
  }),

  s("subparser", {
    t"parser_", i(1, "name"), t" = subparsers.add_parser(",
    t({"","\t'"}), f(copy, 1), t"', help='", i(2, "helptext"), t"')",
    t({"",""}), i(0, "# add arguments here"),
    t({"","parser_"}), f(copy, 1), t".set_defaults(func=", i(3, "default_func"), t")",
    t({"",""})
  }),

  s("format_class", {
    t"class Format(object):",
    t({"",'\tCLEAR = "\\033[0m"'}),
    t({"",'\tBOLD = "\\033[1m"'}),
    t({"",'\tITALIC = "\\033[3m"'}),
    t({"",'\tUNDERLINE = "\\033[4m"'}),
    t({"",'\tRED = "\\033[1;31m"'}),
    t({"",'\tGREEN = "\\033[1;32m"'}),
    t({"",'\tYELLOW = "\\033[1;33m"'}),
    t({"",'\tBLUE = "\\033[1;34m"'}),
    t({"",'\tMAGENTA = "\\033[1;35m"'}),
    t({"",'\tCYAN = "\\033[1;36m"'}),
  }),

  s("ansible_filter", {
    t"from ansible.errors import AnsibleFilterError",
    t({"",""}),
    t({"",""}),
    t({"","def "}), i(1, "my_filter"), t"(", i(2, "data"), t"):",
    t({"","    if not isinstance("}), f(copy, 2), t", ", i(3, "type"), t"):",
    t({"","        raise AnsibleFilterError("}),
    t({"","            \"Input variable for this filter need to be of type "}), f(copy, 3), t".\"",
    t({"","        )"}),
    t({"",""}),
    t({"","    # Process input data"}),
    t({"","    "}), i(4, "output"), t" = ", i(0),
    t({"","    "}),
    t({"","    return "}), f(copy, 4),
    t({"","    "}),
    t({"","    "}),
    t({"","# Register the filters"}),
    t({"","class FilterModule(object):"}),
    t({"","    def filters(self):"}),
    t({"","        return {"}),
    t({"","            \""}), f(copy, 1), t"\": ", f(copy, 1), t",",
    t({"","        }"}),
  }),
}

return snippets
