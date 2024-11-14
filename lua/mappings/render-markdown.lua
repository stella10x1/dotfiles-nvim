-- mappings file for render-markdown.

local map = vim.keymap.set

map("n", "<leader>tr", "<cmd> RenderMarkdown toggle<CR>", { desc = "Toggle Rendering markdown" })

-- End of file.
