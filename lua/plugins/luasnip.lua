-- plugin file for plugin name.

-- basic configuration inherited from NvChad.

return {
  "L3MON4D3/LuaSnip",
  init = function()
    require "mappings.luasnip"
  end,
  opts = require "configs.luasnip",
}

-- End of file.
