-- config file for telescope.nvim.

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local copy_to_clipboard_and_reg_t = function(prompt_bufnr)
  local entry_value = action_state.get_selected_entry().value

  vim.fn.setreg("+", entry_value)
  vim.fn.setreg("t", entry_value)

  actions.close(prompt_bufnr)

  print("Copied value to clipboard and reg t: '" .. entry_value .. "'")
end

local function get_max_depth()
  if vim.loop.cwd() == os.getenv "HOME" or vim.loop.cwd() == "/home" or vim.loop.cwd() == "/" then
    return 1
  else
    return 2
  end
end

local options = {
  extensions = {
    bibtex = {
      depth = get_max_depth(),
      mappings = {
        i = {
          -- restore default of closing the picker with <C-c>
          ["<C-c>"] = require("telescope.actions").close,
          -- append citatation, using a deferred execution to allow lazy loading
          ["<C-a>"] = function (prompt_bufnr)
            local citation_format = "{{author}} ({{year}}), {{title}}."
            local bibtex_actions = require("telescope-bibtex.actions")
            bibtex_actions.citation_append(citation_format)(prompt_bufnr)
          end,
        },
      },
      wrap = true,
    },
  },

  defaults = {
    mappings = {
      i = {
        ["<C-y>"] = function(prompt_bufnr)
          copy_to_clipboard_and_reg_t(prompt_bufnr)
        end,
      },
      n = {
        ["<C-y>"] = function(prompt_bufnr)
          copy_to_clipboard_and_reg_t(prompt_bufnr)
        end,
      },
    },
  },
}

return options

-- End of file.
