-- plugin file for zk.nvim.

return {
  {
    "zk-org/zk-nvim",
    cmd = { "ZkBacklinks", "ZkIndex", "ZkLinks", "ZkNew", "ZkNotes", "ZkTags", "ZkCd" },
    init = function()
      require "mappings.zk"
    end,
    opts = require "configs.zk",
    config = function(_, opts)
      require("zk").setup(opts)
    end,
  },
}

-- End of file.
