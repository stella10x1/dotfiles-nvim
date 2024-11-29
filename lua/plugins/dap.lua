-- plugin file for nvim-dap and nvim-dap-ui.

return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    {
      "nvim-neotest/nvim-nio",
    },
    {
      "mfussenegger/nvim-dap",
    },
    {
      "theHamsta/nvim-dap-virtual-text",
    },
  },
  init = function()
    require "mappings.dap"
  end,
  config = function()
    require("dapui").setup()
    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
  end,
}

-- End of file.
