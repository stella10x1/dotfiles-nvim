-- Neovim configuration
--
-- lua/hl-groups-custom.lua
--
-- Custom highlight definitions for local usage.

vim.api.nvim_set_hl(0, "AllowedTrailingSpaces", {
  -- This highlight group is used to visualize allowed spaces at the end of a line.
  -- It creates a underline in an friendly green tone.
  fg = "#3cb371",
  underline = true,
})

vim.api.nvim_set_hl(0, "ForbiddenTrailingSpaces", {
  -- This highlight group is used to visualize forbidden spaces at the end of a line.
  -- It is a bright red and occupies the whole cell.
  bg = "#ff0000",
  ctermbg = 1,
})
