-- plugin file for nvim-lspconfig.

-- basic configuration inherited from NvChad.

return {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
}

-- End of file.
