-- plugin file for nvim-lint.

return {
  "mfussenegger/nvim-lint",
  config = function()
    require("configs.lint").setup()
  end,
  ft = { "markdown" },
  init = function()
    require "mappings.lint"
  end,
}

-- End of file.
