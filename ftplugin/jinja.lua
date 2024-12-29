if not vim.b.jinja_syntax_autocmd_loaded then
  if vim.treesitter.language.get_lang "jinja" == nil then
    vim.api.nvim_create_autocmd("FileType", {
      buffer = 0,
      callback = function()
        if vim.fn.empty(vim.bo.filetype) == 0 then
          vim.opt_local.syntax = "on"
          require("utils").disable_lint(0)
        end
      end,
    })
  end
  vim.b.jinja_syntax_autocmd_loaded = true
end
