-- plugin file for telescope.nvim.

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local copy_to_clipboard_and_reg_t = function(prompt_bufnr)
  local entry_value = action_state.get_selected_entry().value

  vim.fn.setreg("+", entry_value)
  vim.fn.setreg("t", entry_value)

  actions.close(prompt_bufnr)

  print("Copied value to clipboard and reg t: '" .. entry_value .. "'")
end

local options = {
  defaults = {
    mappings = {
      i = {
        ["<C-y>"] = function (prompt_bufnr)
          copy_to_clipboard_and_reg_t(prompt_bufnr)
        end,
      },
      n = {
        ["<C-y>"] = function (prompt_bufnr)
          copy_to_clipboard_and_reg_t(prompt_bufnr)
        end,
      },
    },
  },
}

return options

-- End of file.
