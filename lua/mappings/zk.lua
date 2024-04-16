-- mappings file for zk.nvim

local map = vim.keymap.set

map("n", "<leader>zt", function()
  require("zk.commands").get "ZkTags"()
end, { desc = "Zk Search for zk tags" })

map("n", "<leader>zz", function()
  require("zk").edit { sort = { "modified" } }
end, { desc = "Zk Search for zk notes" })

map("n", "<leader>zn", function()
  require("zk_funcs").new_zk_note_in_subfolder()
end, { desc = "Zk Create new note in ZK_DIR subfolder" })
