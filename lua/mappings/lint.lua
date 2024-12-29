-- mappings file for nvim-lint.

local map = vim.keymap.set

map("n", "<leader>tl", function()
  require("utils").toggle_lint()
end, { desc = "Toggle Rendering lint plugin" })

-- End of file.
