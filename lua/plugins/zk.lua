-- plugin file for zk-nvim.

vim.pack.add({
  { src = "https://github.com/zk-org/zk-nvim" },
})

local map = vim.keymap.set

require("zk").setup({
  picker = "snacks_picker",

  lsp = {
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

map("n", "<leader>zA", function()
  require("zk").edit({ sort = { "modified" } })
end, { desc = "Zk Search for all zk notes" })

map("n", "<leader>zb", function()
  require("zk.commands").get("ZkBuffers")()
end, { desc = "Zk Search for open zk notes" })

map("n", "<leader>zB", function()
  require("zk.commands").get("ZkBacklinks")()
end, { desc = "Zk Show backlinks to this note" })

map("n", "<leader>zD", function()
  require("zk").new({ group = "daily", date = "tomorrow" })
end, { desc = "Zk Creates or opens daily journal note (for today)" })

map("n", "<leader>zd", function()
  require("zk").new({ group = "daily" })
end, { desc = "Zk Creates or opens daily journal note (for today)" })

map("n", "<leader>zg", function()
  local zk_notebook_dir = os.getenv("ZK_NOTEBOOK_DIR")
  require("snacks").picker.grep({ dirs = { zk_notebook_dir } })
end, { desc = "Zk Live grep over notebook directory" })

map("n", "<leader>zj", function()
  require("zk").edit({ hrefs = { "journal" }, sort = { "modified" } })
end, { desc = "Zk Search for zk journal entries" })

map("n", "<leader>zl", function()
  require("zk.commands").get("ZkLinks")()
end, { desc = "Zk Show links from this note to other notes" })

map("n", "<leader>zM", function()
  require("zk").new({ group = "monthly", date = "next month" })
end, { desc = "Zk Creates or opens monthly journal note (for next month)" })

map("n", "<leader>zm", function()
  require("zk").new({ group = "monthly" })
end, { desc = "Zk Creates or opens monthly journal note (for this month)" })

map("n", "<leader>zn", function()
  require("zk_funcs").new_zk_note_in_subfolder()
end, { desc = "Zk Create new note in ZK_DIR subfolder" })

map("n", "<leader>zq", function()
  require("zk").new({ group = "temp" })
end, { desc = "Zk Create quick / temp note" })

map("n", "<leader>zt", function()
  require("zk.commands").get("ZkTags")()
end, { desc = "Zk Search for zk tags" })

map("n", "<leader>zW", function()
  require("zk").new({ group = "weekly", date = "next week" })
end, { desc = "Zk Creates or opens weekly journal note (for next week)" })

map("n", "<leader>zw", function()
  require("zk").new({ group = "weekly" })
end, { desc = "Zk Creates or opens weekly journal note (for this week)" })

map("n", "<leader>zy", function()
  require("zk").new({ group = "daily", date = "yesterday" })
end, { desc = "Zk Creates or opens yesterdays journal entry" })

map("n", "<leader>zz", function()
  require("zk").edit({ excludeHrefs = { "journal" }, sort = { "modified" } })
end, { desc = "Zk Search for zk notes excluding journal entries" })
