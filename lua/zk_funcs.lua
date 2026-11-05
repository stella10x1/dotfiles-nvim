-- helper functions for zk.nvim.

local M = {}

-- Select a top-level folder of the current notebook and create a new note in it.
M.new_zk_note_in_subfolder = function()
  local util = require("zk.util")
  local zk_dir = util.notebook_root(util.resolve_notebook_path(0))
  if not zk_dir then
    vim.notify("No zk notebook found", vim.log.levels.WARN)
    return
  end

  local dirs = {}
  for name, type in vim.fs.dir(zk_dir) do
    if type == "directory" and not vim.startswith(name, ".") then
      table.insert(dirs, name)
    end
  end
  table.sort(dirs)

  vim.ui.select(dirs, { prompt = "New Zk Note Subfolder" }, function(choice)
    if choice then
      require("zk.commands").get("ZkNew")({ dir = vim.fs.joinpath(zk_dir, choice) })
    end
  end)
end

return M
