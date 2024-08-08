-- plugin file for telescope.nvim.

-- basic configuration inherited from NvChad.

return {
  "nvim-telescope/telescope.nvim",
  opts = require "configs.telescope",
  init = function()
    require "mappings.telescope"
  end,
}

-- End of file.
