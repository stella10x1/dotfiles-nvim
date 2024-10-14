-- config file for LuaSnip.

local types = require "luasnip.util.types"

return {
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "  ●", "LuaSnipChoiceNodeHintDot" } },
        hl_mode = "combine",
      },
    },
  },
}

-- End of file.
