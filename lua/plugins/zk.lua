return {
  {
    "zk-org/zk-nvim",
    cmd = { "ZkIndex", "ZkLinks", "ZkNew", "ZkNotes", "ZkTags", "ZkCd" },
    init = function()
      require "mappings.zk"
    end,
    opts = function()
      return {
        picker = "telescope",

        lsp = {
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      }
    end,
    config = function(_, opts)
      require("zk").setup(opts)
    end,
  },
}
