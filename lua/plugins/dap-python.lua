-- plugin file for nvim-dap-python.

return {
  "mfussenegger/nvim-dap-python",
  dependencies = {
    "mfussenegger/nvim-dap-ui",
  },
  ft = {
    "python",
  },
  config = function()
    require("dap-python").setup "python3"
  end,
}

-- End of file.
