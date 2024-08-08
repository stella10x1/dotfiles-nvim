-- mappings file for conform.nvim.

local map = vim.keymap.set

map("n", "<leader>FF", function()
  require("conform").format()
end, { desc = "Buffer Code formatting" })

-- End of file.
