-- config file for nvim-lint.

local M = {}

M.setup = function()
  local lint = require "lint"

  lint.linters_by_ft = {
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
end

return M

-- End of file.
