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

-- Select a top-level folder of the current notebook and create a new note in it.
local function new_note_in_subfolder()
  local util = require("zk.util")
  local zk_dir = util.notebook_root(util.resolve_notebook_path(0))
  if not zk_dir then
    vim.notify("No zk notebook found", vim.log.levels.WARN)
    return
  end

  local dirs = {}
  for name, type in vim.fs.dir(zk_dir) do
    if type == "directory" and not vim.startswith(name, ".") then
      table.insert(dirs, name)
    end
  end
  table.sort(dirs)

  vim.ui.select(dirs, { prompt = "New Zk Note Subfolder" }, function(choice)
    if choice then
      require("zk.commands").get("ZkNew")({ dir = vim.fs.joinpath(zk_dir, choice) })
    end
  end)
end

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

map("n", "<leader>zn", new_note_in_subfolder, { desc = "Zk Create new note in ZK_DIR subfolder" })

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
