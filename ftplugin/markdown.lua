local opt_local = vim.opt_local

opt_local.tabstop = 4
opt_local.softtabstop = 0
opt_local.expandtab = true
opt_local.shiftwidth = 4
opt_local.smarttab = true
opt_local.textwidth = 80
opt_local.spell = true
opt_local.spelllang = "en_us"

-- change table cornor for vim-table-mode plugin
vim.b["table_mode_corner"] = "|"
vim.b["table_mode_separator"] = "|"

-- load shortcuts if in an zk directory
if require("zk.util").notebook_root(vim.fn.expand "%:p") ~= nil then
  require "mappings.buffer.zk"
end
