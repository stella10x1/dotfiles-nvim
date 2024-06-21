return {
  "knubie/vim-kitty-navigator",
  lazy = false,
  config = function()
    vim.g["kitty_navigator_no_mappings"] = 1
  end,
  init = function()
    require "mappings.vim-kitty-navigator"
  end,
}
