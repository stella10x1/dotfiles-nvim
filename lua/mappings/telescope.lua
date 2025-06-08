-- mappings file for telescope.nvim.

require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- disable some NvChad default mappings.
nomap("n", "<leader>cm") -- default for Telescope git_commits
nomap("n", "<leader>fa") -- default for Telescope find_files (all)
nomap("n", "<leader>fw") -- default for Telescope live_grep
nomap("n", "<leader>fm") -- default for formatting buffer with conform
nomap("n", "<leader>gt") -- default for Telescope git_commits

-- custom telescope mappings.
map("n", "<leader>fa", function()
  return require("telescope.builtin").find_files { no_ignore = true }
end, { desc = "Telescope Find all files (gitignored, but no hidden)" })

map("n", "<leader>fc", function()
  return require("telescope").extensions.bibtex.bibtex()
end, { desc = "Telescope Bibtex search (Cite)" })

map("n", "<leader>fl", function()
  return require("telescope.builtin").live_grep()
end, { desc = "Telescope Live grep" })

map("n", "<leader>fm", function()
  return require("telescope.builtin").man_pages { sections = { "1", "5" } }
end, { desc = "Telescope Man pages section 1 and 5" })

map("n", "<leader>fM", function()
  return require("telescope.builtin").man_pages { sections = { "1", "2", "3", "4", "5", "6", "7", "8" } }
end, { desc = "Telescope Man pages all sections" })

map("n", "<leader>fo", function()
  return require("telescope.builtin").vim_options()
end, { desc = "Telescope Vim options" })

map("n", "<leader>fr", function()
  return require("telescope.builtin").registers()
end, { desc = "Telescope Vim registers" })

map("n", "<leader>fz", function()
  return require("telescope.builtin").spell_suggest()
end, { desc = "Telescope Spell suggestions" })

map("n", "<leader>f/", function()
  return require("telescope.builtin").search_history()
end, { desc = "Telescope Search history" })

map("n", "<leader>f:", function()
  return require("telescope.builtin").command_history()
end, { desc = "Telescope Command history" })

map("n", "<leader>f.", function()
  return require("telescope.builtin").find_files { no_ignore = true, hidden = true }
end, { desc = "Telescope Find all files (gitignored and hidden)" })

map("n", "<leader>gb", function()
  return require("telescope.builtin").git_branches()
end, { desc = "Git Branch overview " })

-- End of file.
