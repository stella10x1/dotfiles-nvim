local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local zk_dir = require("zk.util").notebook_root(require("zk.util").resolve_notebook_path(0))

-- Lua implementation of PHP scandir function
-- Source https://stackoverflow.com/a/11130774
-- Author Bobby Oster, CC-BY-SA
-- Start code from Bobby Oster
local scandir = function(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -l "' .. directory .. '" | grep "^d" | grep -o "[a-zA-Z0-9]*$"')
  if pfile ~= nil then
    for filename in pfile:lines() do
      i = i + 1
      t[i] = filename
    end
    pfile:close()
  end
  return t
end
-- End code from Bobby Oster

M = {}

M.new_zk_note_in_subfolder = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "New Zk Note Subfolder",
      finder = finders.new_table {
        results = scandir(zk_dir),
      },
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          require("zk.commands").get "ZkNew" { dir = zk_dir .. "/" .. selection[1] }
        end)
        return true
      end,
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

-- to execute the function
return M
