-- this file contains overrides for the NvChad default plugins

local cmp = require "cmp"

return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      completion = {
        completeopt = "menuone,preview,noselect",
      },
      mapping = {
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(1) then
            require("luasnip").expand_or_jump()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "json",
        "markdown",
        "python",
        "yaml",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        git_ignored = false,
      },
      git = {
        enable = true,
      },

      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },
}
