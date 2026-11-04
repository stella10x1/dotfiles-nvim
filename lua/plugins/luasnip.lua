-- plugin file for LuaSnip.

vim.pack.add {
  { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range "2.*" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
}

local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.setup {
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "  ●", "LuaSnipChoiceNodeHintDot" } },
        hl_mode = "combine",
      },
    },
  },
}

-- own snippets (previously loaded by NvChad via vim.g.lua_snippets_path)
require("luasnip.loaders.from_lua").lazy_load { paths = { vim.fn.stdpath "config" .. "/lua_snippets" } }
-- friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

local map = vim.keymap.set

map({ "i", "s" }, "<C-e>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { desc = "LuaSnip Next choice on node" })

-- End of file.
