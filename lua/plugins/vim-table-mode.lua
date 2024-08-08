-- plugin file for vim-table-mode.

return {
  "dhruvasagar/vim-table-mode",
  cmd = { "TableModeToggle", "TableModeEnable", "TableSort" },
  init = function()
    require "mappings.vim-table-mode"
  end,
}

-- End of file.
