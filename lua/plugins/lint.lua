-- plugin file for nvim-lint.

vim.pack.add({
  { src = 'https://github.com/mfussenegger/nvim-lint' }
})

local lint = require "lint"

lint.linters_by_ft = {
  cpp = { "cppcheck", args = { "--project=compile_commands.json"} },
  markdown = { "markdownlint-cli2" },
}

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  callback = function()
    local lint_enabled = require("utils").get_lint_enabled(0)
    if lint_enabled == true then
      lint.try_lint()
    end
  end,
})

local map = vim.keymap.set

map("n", "<leader>tl", function()
  require("utils").toggle_lint()
end, { desc = "Toggle Rendering lint plugin" })

-- End of file.
