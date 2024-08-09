-- buffer mappings file for zk.nvim.

local map = vim.keymap.set

map("n", "<CR>", function()
  vim.lsp.buf.definition()
end)

map("n", "K", function()
  vim.lsp.buf.hover()
end)

-- End of file.
