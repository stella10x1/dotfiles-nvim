require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

------------------------------------------------------------
-- Mappings for Default NeoVim Functions
------------------------------------------------------------

-- normal mode
map("n", "<C-s>", ":w<CR>")
map("n", "<C-v>", '"+p', { desc = "Insert Paste from system clipboard" })
map("n", "<M-p>", ":bprevious<CR>", { desc = "Buffer To previous buffer" })
map("n", "<M-n>", ":bnext<CR>", { desc = "Buffer To next buffer" })
map("n", "<M-o>", "o<ESC>k", { desc = "Insert Empty line below" })
map("n", "<M-O>", "O<ESC>j", { desc = "Insert Empty line above" })
map("n", "<leader>sd", "<cmd>set spell spelllang=de<CR>", { desc = "Spell Activate spell check and set to DE" })
map("n", "<leader>se", "<cmd>set spell spelllang=en<CR>", { desc = "Spell Activate spell check and set to EN" })
map("n", "<leader>S", "<cmd>set spell!<CR>", { desc = "Spell Toggle spell check" })

-- insert mode
map("i", "<C-s>", "<ESC>:w<CR>", { desc = "File Save the buffer and leave insert mode" })
map("i", "<M-p>", "<ESC>:bprevious<CR>", { desc = "Buffer Leave insert and jump to previous buffer" })
map("i", "<M-n>", "<ESC>:bnext<CR>", { desc = "Buffer Leave insert and jump to next buffer" })
map("i", "<C-v>", '<ESC>"+pa', { desc = "Paste from clipboard" })

-- visual mode
map("v", "<C-s>", "<ESC>:w<CR>gv", { desc = "File Save the buffer and keep selection" })
map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
map("v", "<C-x>", '"+d', { desc = "Cut to system clipboard" })

-- selection mode
map("s", "<C-s>", "<ESC>:w<CR>", { desc = "File Save the buffer and leave select mode" })
map("s", "<C-v>", '<DEL>"+Pa', { desc = "Paste from system clipboard" })

------------------------------------------------------------
-- NvChad Default Plugin Mappings
------------------------------------------------------------

-- disable some NvChad default mappings
nomap("n", "<leader>cm") -- default for Telescope git_commits
nomap("n", "<leader>fa")
nomap("n", "<leader>fw")
nomap("n", "<leader>fm")
nomap("n", "<leader>gt")  -- default for Telescope git_commits
nomap("n", "<leader>h") -- default for open horizontal term
nomap("n", "<leader>v") -- default for open vertical term
nomap("n", "<leader>th") -- default for NvChad theme selector

nomap("i", "<C-h>")
nomap("i", "<C-j>")
nomap("i", "<C-k>")
nomap("i", "<C-l>")

-- general functions
map("n", "<leader>tt", function()
  return require("base46").toggle_theme()
end, { desc = "Toggle Theme" })

-- Telescope mappings
map("n", "<leader>fa", function()
  return require("telescope.builtin").find_files { no_ignore = true }
end, { desc = "Telescope Find all files (gitignored, but no hidden)" })

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

map("n", "<leader>gc", function ()
  return require("telescope.builtin").git_commits()
end, { desc = "Git Commit overview in Telescope" })

map("n", "<leader>gs", function ()
  return require("telescope.builtin").git_status()
end, { desc = "Git Status overview in Telescope" })

-- new terminals
map("n", "<leader>H", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>V", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical window" })

-- LuaSnip control
local ls = require "luasnip"
map({ "i", "s" }, "<C-e>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { desc = "LuaSnip Next choice on node" })
