-- mappings file for LuaSnip.

local map = vim.keymap.set
local ls = require "luasnip"

map({ "i", "s" }, "<C-e>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { desc = "LuaSnip Next choice on node" })

-- End of file.
