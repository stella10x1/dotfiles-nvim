-- mappings file for diffview.

local map = vim.keymap.set

map("n", "<leader>gd", "<cmd> DiffviewFileHistory %<CR>", { desc = "Git Diffview history for current file" })
map("n", "<leader>gD", "<cmd> DiffviewOpen<CR>", { desc = "Git Diffview for current worktree" })
map("n", "<leader>gq", "<cmd> DiffviewClose<CR>", { desc = "Git Close Diffview tab" })
