-- mappings file for aerial.nvim

local map = vim.keymap.set

map("n", "<leader>a", function()
  return require("aerial").open()
end, { desc = "Aerial Tagbar open or focus" })

map("n", "<leader>A", function()
  return require("aerial").nav_toggle()
end, { desc = "Aerial Tag navigation toggle" })

map("n", "<leader>fs", function()
  return require("telescope").extensions.aerial.aerial()
end, { desc = "Aerial Find symbols in current buffer" })
