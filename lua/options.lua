local o = vim.o

o.cursorlineopt = "both" -- to enable cursorline!
o.clipboard = "" -- disable use system clipboard for all yank and paste operations
o.linebreak = true -- break at whitespace instead of last character on screen
o.number = true

-- Indention

o.expandtab = true
o.tabstop = 4 -- display width of a tab
o.shiftwidth = 4 -- indentation width
o.softtabstop = 4 -- spaces inserted/deleted when pressing Tab/Backspace
