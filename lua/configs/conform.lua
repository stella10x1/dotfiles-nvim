-- config file for conform.nvim.

local options = {
  formatters_by_ft = {
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    javascript = { "prettier" },
    lua = { "stylua" },
    python = { "black" },
    yaml = { "prettier" },
  },
}

return options

-- End of file.
