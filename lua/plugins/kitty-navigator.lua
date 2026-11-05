-- plugin file for vim-kitty-navigator.

vim.pack.add({
  { src = "https://github.com/knubie/vim-kitty-navigator" },
})

local map = vim.keymap.set

-- vim-kitty-navigator only maps normal mode
map(
  "t",
  "<C-j>",
  "<C-\\><C-N><cmd>KittyNavigateDown<CR>",
  { desc = "Terminal Leave insert and move down (or kitty pane)" }
)
map("t", "<C-k>", "<C-\\><C-N><cmd>KittyNavigateUp<CR>", { desc = "Terminal Leave insert and move up (or kitty pane)" })
map(
  "t",
  "<C-h>",
  "<C-\\><C-N><cmd>KittyNavigateLeft<CR>",
  { desc = "Terminal Leave insert and move left (or kitty pane)" }
)
map(
  "t",
  "<C-l>",
  "<C-\\><C-N><cmd>KittyNavigateRight<CR>",
  { desc = "Terminal Leave insert and move right (or kitty pane)" }
)
