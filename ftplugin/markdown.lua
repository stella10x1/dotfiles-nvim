local opt_local = vim.opt_local

opt_local.tabstop = 2
opt_local.softtabstop = 0
opt_local.expandtab = true
opt_local.shiftwidth = 2
opt_local.smarttab = true
opt_local.textwidth = 80
opt_local.spell = true
opt_local.spelllang = "en_us"

-- change table cornor for vim-table-mode plugin
vim.b["table_mode_corner"] = "|"
vim.b["table_mode_separator"] = "|"

-- load shortcuts if in an zk directory
if require("zk.util").notebook_root(vim.fn.expand "%:p") ~= nil then
  require "mappings.buffer.zk"
end

local function highlight_trailing_spaces()
  vim.api.nvim_buf_clear_namespace(0, 0, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- iterate over all lines
  for i, line in ipairs(lines) do
    -- using the # operator returns the line length of an object
    local line_length = #line

    -- matches exactly two whitespaces at the end of a line an not more or less
    -- %s reflect a whitespace
    if line:match "%s%s$" and not line:match "%s%s%s$" then
      vim.api.nvim_buf_add_highlight(0, 0, "AllowedTrailingSpaces", i - 1, #line - 2, #line)
    end

    -- matches every amount of whitespaces at the end of the line except two
    -- %S reflect any character, which is not whitespace
    if line:match "%s$" and not line:match "%S%s%s$" then
      local match_start = line:match "^(.*%S)%s*$"
      local num_trailing_spaces = line_length - #match_start
      vim.api.nvim_buf_add_highlight(
        0,
        0,
        "ForbiddenTrailingSpaces",
        i - 1,
        line_length - num_trailing_spaces,
        line_length
      )
    end
  end
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
  callback = highlight_trailing_spaces,
  pattern = "*.md",
})
