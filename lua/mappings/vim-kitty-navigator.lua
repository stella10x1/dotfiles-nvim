-- mappings file for vim-kitty-navigator.

require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

nomap("n", "<C-h>")
nomap("n", "<C-j>")
nomap("n", "<C-k>")
nomap("n", "<C-l>")

map("n", "<C-h>", "<cmd>KittyNavigateLeft<CR>", { desc = "Navigate Left window or kitty pane" })
map("n", "<C-j>", "<cmd>KittyNavigateDown<CR>", { desc = "Navigate Down window or kitty pane" })
map("n", "<C-k>", "<cmd>KittyNavigateUp<CR>", { desc = "Navigate Up window or kitty pane" })
map("n", "<C-l>", "<cmd>KittyNavigateRight<CR>", { desc = "Navigate Right window or kitty pane" })

-- End of file.
