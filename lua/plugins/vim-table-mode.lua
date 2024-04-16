return {
  "dhruvasagar/vim-table-mode",
  cmd = { "TableModeToggle", "TableModeEnable", "TableSort" },
  init = function()
    require "mappings.vim-table-mode"
  end,
}
