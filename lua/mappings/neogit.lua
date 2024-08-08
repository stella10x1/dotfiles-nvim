-- mappings file for neogit.

local map = vim.keymap.set

-- "<leader>gb": Telescope git_branches

map("n", "<leader>gc", function()
  return require("neogit").open { "commit" }
end, { desc = "Git Commit" })

-- "<leader>gd": Diffview File History
-- "<leader>gD": Diffview Open

map("n", "<leader>gl", function()
  return require("neogit").open { "log" }
end, { desc = "Git Log" })

map("n", "<leader>gL", "<cmd> NeogitLogCurrent<CR>", { desc = "Git Log for file" })

map("n", "<leader>gp", function()
  return require("neogit").open { "pull" }
end, { desc = "Git Pull" })

map("n", "<leader>gP", function()
  return require("neogit").open { "push" }
end, { desc = "Git Push" })

map("n", "<leader>gr", function()
  return require("neogit").open { "rebase" }
end, { desc = "Git Pull" })

map("n", "<leader>gs", function()
  return require("neogit").open { kind = "tab" }
end, { desc = "Git Status" })

map("n", "<leader>G", function()
  return require("neogit").open { kind = "floating" }
end, { desc = "Git Status as floating window" })

