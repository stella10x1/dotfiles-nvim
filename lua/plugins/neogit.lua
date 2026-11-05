vim.pack.add({
  { src = "https://github.com/NeogitOrg/neogit" },
})

require("neogit").setup({
  commit_editor = {
    kind = "auto",
  },
  git_services = {
    ["git.10x1.eu"] = {
      pull_request = "https://${host}/${owner}/${repository}/compare/${branch_name}",
      commit = "https://${host}/${owner}/${repository}/commit/${oid}",
      tree = "https://${host}/${owner}/${repository}/src/branch/${branch_name}",
    },
  },
  graph_style = "kitty",
  mappings = {
    rebase_editor = {
      -- Remove quick actions for rebase editor

      -- ["b"] = "Break",
      ["b"] = false,
      -- ["d"] = "Drop",
      ["d"] = false,
      -- ["e"] = "Edit",
      ["e"] = false,
      -- ["f"] = "Fixup",
      ["f"] = false,
      -- ["p"] = "Pick",
      ["p"] = false,
      -- ["q"] = "Close",
      ["q"] = false,
      -- ["r"] = "Reword",
      ["r"] = false,
      -- ["s"] = "Squash",
      ["s"] = false,
      -- ["x"] = "Execute",
      ["x"] = false,
    },
  },
})

-- mappings file for neogit.

local map = vim.keymap.set

-- "<leader>gb": Telescope git_branches

map("n", "<leader>gc", function()
  return require("neogit").open({ "commit" })
end, { desc = "Git Commit" })

-- "<leader>gd": Diffview File History
-- "<leader>gD": Diffview Open

map("n", "<leader>gl", function()
  return require("neogit").open({ "log" })
end, { desc = "Git Log" })

map("n", "<leader>gL", "<cmd> NeogitLogCurrent<CR>", { desc = "Git Log for file" })

map("n", "<leader>gp", function()
  return require("neogit").open({ "pull" })
end, { desc = "Git Pull" })

map("n", "<leader>gP", function()
  return require("neogit").open({ "push" })
end, { desc = "Git Push" })

map("n", "<leader>gr", function()
  return require("neogit").open({ "rebase" })
end, { desc = "Git Pull" })

map("n", "<leader>gs", function()
  return require("neogit").open({ kind = "tab" })
end, { desc = "Git Status" })

map("n", "<leader>G", function()
  return require("neogit").open({ kind = "floating" })
end, { desc = "Git Status as floating window" })
