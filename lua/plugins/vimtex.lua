-- plugin file for vimtex.

return {
  "lervag/vimtex",
  -- vimtex is mostly a ftplugin and therefore naturally "lazy loaded".
  lazy = false,
  config = function()
    require "configs.vimtex"
  end,
}

-- End of file.
