local jupynium_venv = vim.fn.stdpath "data" .. "/jupynium.nvim/venv"
local jupynium_pip = jupynium_venv .. "/bin/pip3"

return {
  "kiyoon/jupynium.nvim",
  build = {
    "python -m venv " .. jupynium_venv,
    jupynium_pip .. " install --upgrade pip",
    jupynium_pip .. " install .",
  },
  config = function()
    require("jupynium").setup {
      python_host = jupynium_venv .. "/bin/python3",
      default_notebook_URL = "localhost:8890/nbclassic",
      use_default_keybindings = true,
    }
  end,
  lazy = true,
  cmd = "JupyniumStartAndAttachToServer",
}
