vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
  callback = function()
    local lang = require("frontmatter").parse_lang()
    if lang then
      vim.opt_local.spelllang = lang
    end
  end,
  pattern = "*.md",
})
