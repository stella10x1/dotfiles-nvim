-- config file for conform.nvim.

local options = {
  formatters_by_ft = {
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    python = { "black" },
    yaml = { "prettier" },
  },
}

return options

-- End of file.
