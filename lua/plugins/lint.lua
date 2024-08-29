-- plugin file for nvim-lint.

return {
  "mfussenegger/nvim-lint",
  config = function()
    require("configs.lint").setup()
  end,
  ft = { "markdown" },
}

-- End of file.
