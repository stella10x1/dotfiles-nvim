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

map("n", "<leader><leader>", function()
  vim.cmd.edit(vim.fn.stdpath('state') .. '/scratch.md')
end, { desc = "Notes Open scratchpad note" })

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

map("t", "<ESC>", "<C-\\><C-N>", { desc = "Terminal Leave insert mode" })

------------------------------------------------------------
-- NvChad Default Plugin Mappings
------------------------------------------------------------


nomap("n", "<leader>th") -- default for NvChad theme selector

nomap("n", "<leader>h") -- default for open horizontal term
nomap("n", "<leader>v") -- default for open vertical term
nomap("i", "<C-h>")
nomap("i", "<C-j>")
nomap("i", "<C-k>")
nomap("i", "<C-l>")

-- general functions
map("n", "<leader>tt", function()
  return require("base46").toggle_theme()
end, { desc = "Toggle Theme" })

-- new terminals
map("n", "<leader>H", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>V", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical window" })
