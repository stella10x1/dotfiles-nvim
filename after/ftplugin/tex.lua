local opt_local = vim.opt_local

opt_local.tabstop = 4
opt_local.softtabstop = 4
opt_local.shiftwidth = 4

opt_local.spell = true
opt_local.spelllang = "de_de"
opt_local.spellsuggest = { "best", 10 }

opt_local.foldmethod = "expr"
opt_local.foldexpr = "vimtex#fold#level(v:lnum)"
opt_local.foldtext = "vimtex#fold#text()"
opt_local.fillchars = "fold: "
