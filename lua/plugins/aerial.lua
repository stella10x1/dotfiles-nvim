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
  opts = function()
    return { nav = { keymaps = { ["q"] = "actions.close" } } }
  end,
  config = function(_, opts)
    require("aerial").setup(opts)
    require("telescope").load_extension "aerial"
  end,
}
