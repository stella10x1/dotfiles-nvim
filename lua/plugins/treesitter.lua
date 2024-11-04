-- plugin file for nvim-treesitter.

-- basic configuration inherited from NvChad.

return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = require "configs.treesitter",
}

-- End of file.
