-- plugin file for zk.nvim.

return {
  {
    "zk-org/zk-nvim",
    cmd = { "ZkIndex", "ZkLinks", "ZkNew", "ZkNotes", "ZkTags", "ZkCd" },
    init = function()
      require "mappings.zk"
    end,
    opts = require "mappings.zk",
    config = function(_, opts)
      require("zk").setup(opts)
    end,
  },
}

-- End of file.
