-- plugin file for codediff.nvim.

vim.pack.add({
  { src = "https://github.com/esmuellert/codediff.nvim" },
})

local map = vim.keymap.set

map("n", "<leader>gd", "<cmd>CodeDiff history %<CR>", { desc = "Git Diff history of current file" })
-- in visual mode, limit the history to commits that changed the selected lines
map("x", "<leader>gd", ":CodeDiff history<CR>", { silent = true, desc = "Git Diff history of selected lines" })
map("n", "<leader>gD", "<cmd>CodeDiff<CR>", { desc = "Git Diff working tree changes" })

-- End of file.
