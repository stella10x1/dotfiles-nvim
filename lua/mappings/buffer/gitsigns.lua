-- buffer mappings file for gitsigns.nvim.

local on_attach = function(bufnr)
  local gitsigns = package.loaded.gitsigns

  -- overwrite map function to give a default option.
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal { "]c", bang = true }
    else
      gitsigns.nav_hunk("next", { target = "unstaged" })
    end
  end, { desc = "Git Next unstaged hunk" })

  map("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal { "[c", bang = true }
    else
      gitsigns.nav_hunk("prev", { target = "unstaged" })
    end
  end, { desc = "Git Previous unstaged hunk" })

  map("n", "]h", function()
    gitsigns.nav_hunk("next", { target = "all" })
  end, { desc = "Git Next hunk (all)" })

  map("n", "[h", function()
    gitsigns.nav_hunk("prev", { target = "all" })
  end, { desc = "Git Previous hunk (all)" })

  map("n", "]H", function()
    gitsigns.nav_hunk("next", { target = "staged" })
  end, { desc = "Git Next staged hunk" })

  map("n", "[H", function()
    gitsigns.nav_hunk("prev", { target = "staged" })
  end, { desc = "Git Previous staged hunk" })

  -- Actions
  map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git Stage hunk to index" })
  map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git Reset hunk from index to HEAD" })
  map("v", "<leader>hs", function()
    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, { desc = "Git Stage hunk to index" })
  map("v", "<leader>hr", function()
    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, { desc = "Git Reset hunk from index to HEAD" })
  map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git Stage all hunks in buffer to index" })
  map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Git Undo staging hunks to index" })
  map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git Reset all hunks in buffer to HEAD" })
  map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git Preview diff of hunk" })
  map("n", "<leader>gb", function()
    gitsigns.blame_line { full = true }
  end, { desc = "Git Blame line under cursor" })
  map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Git Toggle blame line under cursor" })
  map("n", "<leader>gd", gitsigns.diffthis, { desc = "Git Show side by side diff of buffer" })
  map("n", "<leader>gD", function()
    gitsigns.diffthis "~"
  end)
  map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Git Toggle showing lines in buffer" })

  -- Text object
  map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

return on_attach

-- End of file.
