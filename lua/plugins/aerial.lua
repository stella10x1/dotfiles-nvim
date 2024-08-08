-- plugin file for aerial.nvim.

return {
  "stevearc/aerial.nvim",
  cmd = {
    "AerialGo",
    "AerialInfo",
    "AerialNavOpen",
    "AerialNavToggle",
    "AerialOpenAll",
    "AerialToggle",
  },
  init = function()
    require "mappings.aerial"
  end,
  opts = require "configs.aerial",
  config = function(_, opts)
    require("aerial").setup(opts)
    require("telescope").load_extension "aerial"
  end,
}

-- End of file.
