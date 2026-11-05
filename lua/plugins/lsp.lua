-- plugin file for nvim-lspconfig.

vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.enable(require("tools").lsp())

vim.keymap.set("n", "<leader>d", function()
  return vim.diagnostic.open_float()
end, { desc = "Open float diagnostic" })

-- End of file.
