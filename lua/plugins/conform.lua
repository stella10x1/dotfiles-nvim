-- plugin file for conform.nvim.

return {
  "stevearc/conform.nvim",
  init = function()
    require "mappings.conform"
  end,
  opts = require "configs.conform"
}

-- End of file.
