local opt_local = vim.opt_local

-- override defaults from built-in markdown ftplugin
-- changes default spaces to 2 (GFM) instead of 4.
opt_local.tabstop = 2
opt_local.softtabstop = 2
opt_local.expandtab = true
opt_local.shiftwidth = 2
opt_local.smarttab = false
