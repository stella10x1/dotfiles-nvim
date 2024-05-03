-- mappings file for zk.nvim

local map = vim.keymap.set

map("n", "<leader>zt", function()
  require("zk.commands").get "ZkTags"()
end, { desc = "Zk Search for zk tags" })

map("n", "<leader>zz", function()
  require("zk").edit { excludeHrefs = { "journal" }, sort = { "modified" } }
end, { desc = "Zk Search for zk notes excluding journal entries" })

map("n", "<leader>zj", function()
  require("zk").edit { hrefs = { "journal" }, sort = { "modified" } }
end, { desc = "Zk Search for zk journal entries" })

map("n", "<leader>zA", function()
  require("zk").edit { sort = { "modified" } }
end, { desc = "Zk Search for all zk notes" })

map("n", "<leader>zd", function()
  require("zk").new { dir = "journal/daily", group = "daily" }
end, { desc = "Zk Creates or opens daily journal note (for today)" })

map("n", "<leader>zy", function()
  require("zk").new { date = "yesterday", dir = "journal/daily", group = "daily" }
end, { desc = "Zk Creates or opens yesterdays journal entry" })

map("n", "<leader>zn", function()
  require("zk_funcs").new_zk_note_in_subfolder()
end, { desc = "Zk Create new note in ZK_DIR subfolder" })
