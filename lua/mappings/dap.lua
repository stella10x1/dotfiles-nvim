-- mappings file for nvim-dap.

local map = vim.keymap.set

map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Debugger Set or unset breakpoint" })
map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Debugger Continue" })
map("n", "<leader>dr", function()
  require("dapui").open { reset = true }
end, { desc = "Debugger Reset UI" })
map("n", "<leader>dt", function()
  require("dapui").toggle()
end, { desc = "Debugger Toggle UI" })

-- End of file.
