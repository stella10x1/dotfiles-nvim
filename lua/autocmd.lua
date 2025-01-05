vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
  callback = function()
    local lang = require("frontmatter").parse_lang()
    if lang then
      vim.opt_local.spelllang = lang
    end
  end,
  pattern = "*.md",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function ()
    vim.opt_local.signcolumn = "no"
  end,
  pattern = "man",
})
