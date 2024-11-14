local opt_local = vim.opt_local

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

    -- explanation of the patters (`%s` reflects a whitespace character):
    --
    --   * match exactly two whitespaces at the end of the line
    --   * NOT (match three whitespace at the end of the line, applies also for more..)
    --   * NOT (match lines contain only whitespace)
    if line:match "%s%s$" and not line:match "%s%s%s$" and not line:match "^%s*$" then
      vim.api.nvim_buf_add_highlight(0, 0, "AllowedTrailingSpaces", i - 1, #line - 2, #line)
    end

    -- matches every amount of whitespaces at the end of the line except two
    -- %S reflect any character, which is not whitespace
    if line:match "%s$" and not line:match "%S%s%s$" then
      local match_start = line:match "^(.*%S)%s*$"
      local num_trailing_spaces = nil
      -- match_start will be nil, if the line contains only whitespace
      if match_start then
        num_trailing_spaces = line_length - #match_start
      else
        num_trailing_spaces = line_length
      end
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
