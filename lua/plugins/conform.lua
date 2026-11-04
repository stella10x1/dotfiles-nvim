-- plugin file for conform.nvim.

vim.pack.add {
  { src = "https://github.com/stevearc/conform.nvim" },
}

require("conform").setup {
  formatters_by_ft = require("tools").formatters_by_ft(),
}

vim.keymap.set("n", "<leader>FF", function()
  require("conform").format()
end, { desc = "Buffer Code formatting" })

-- End of file.
