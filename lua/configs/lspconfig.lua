-- config file for nvim-lspconfig.

-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local servers = { "bashls", "pyright", "lua_ls", "ansiblels", "texlab" }

vim.lsp.enable(servers)

-- End of file.
