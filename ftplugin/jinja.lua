-- Without a jinja treesitter parser, compound filetypes like yaml.jinja are
-- highlighted with the parser of the first part (e.g. yaml) only. Use the
-- syntax highlighting of jinja.vim instead. Scheduled, because
-- tree-sitter-manager starts treesitter after the ftplugins ran.
if not vim.treesitter.language.add("jinja") then
  local buf = vim.api.nvim_get_current_buf()
  vim.schedule(function()
    if vim.api.nvim_buf_is_valid(buf) then
      vim.treesitter.stop(buf)
    end
  end)
end

-- linters of the base filetype don't understand jinja templates
require("utils").disable_lint(0)
