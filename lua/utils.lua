local M = {}

M.disable_lint = function(bufnr)
  bufnr = bufnr or 0
  vim.b[bufnr].lint_enabled = false

  -- only clear the diagnostics of nvim-lint, not the ones of LSP servers
  local ok, lint = pcall(require, "lint")
  if not ok then
    return
  end
  local names = {}
  for _, linters in pairs(lint.linters_by_ft) do
    for _, name in ipairs(linters) do
      names[name] = true
    end
  end
  for name in pairs(names) do
    vim.diagnostic.reset(lint.get_namespace(name), bufnr)
  end
end

M.enable_lint = function(bufnr)
  bufnr = bufnr or 0
  vim.b[bufnr].lint_enabled = true
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
