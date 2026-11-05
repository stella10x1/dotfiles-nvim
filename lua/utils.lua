local M = {}

M.disable_lint = function(bufnr)
  bufnr = bufnr or 0
  vim.b[bufnr].lint_enabled = false
  vim.diagnostic.reset(nil, 0)
end

M.enable_lint = function(bufnr)
  bufnr = bufnr or 0
  vim.b[bufnr].lint_enabled = false
  require("lint").try_lint()
end

M.get_lint_enabled = function(bufnr)
  bufnr = bufnr or 0
  local lint_enabled = vim.b[bufnr].lint_enabled
  if lint_enabled == nil then
    return true
  end
  return lint_enabled
end

M.toggle_lint = function(bufnr)
  bufnr = bufnr or 0
  if M.get_lint_enabled(bufnr) then
    M.disable_lint(bufnr)
  else
    M.enable_lint(bufnr)
  end
end

return M
