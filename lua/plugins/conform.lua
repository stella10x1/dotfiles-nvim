return {
  "stevearc/conform.nvim",
  init = function()
    require "mappings.conform"
  end,
  config = function()
    require "configs.conform"
  end,
}
