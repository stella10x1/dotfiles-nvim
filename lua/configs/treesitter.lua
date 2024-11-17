-- config file for nvim-treesitter.

return {
  ensure_installed = {
    "bash",
    "html",
    "json",
    "markdown",
    "python",
    "yaml",
  },

  highlight = {
    enable = true,
    disable = {
      "latex",
    },
  },

  indent = {
    disable = { "yaml" },
  },

  textobjects = {
    -- Configuration for nvim-treesitter-textobjects. See upstream documentation for details:
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]/"] = { query = "@comment.outer", desc = "Next comment start" },
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
        ["]a"] = { query = "@assignment.outer", desc = "Next assignment start" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
        ["]f"] = { query = "@frame.outer", desc = "Next frame (LaTeX) start" },
        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
        ["]m"] = { query = "@function.outer", desc = "Next method start" },
        ["]n"] = { query = "@number.inner", desc = "Next number start" },
        ["]p"] = { query = "@parameter.outer", desc = "Next parameter start" },
        ["]r"] = { query = "@return.outer", desc = "Next return start" },
        ["]t"] = { query = "@local.scope", query_group = "locals", desc = "Next TS scope start" },
        ["]v"] = { query = "@attribute.outer", desc = "Next attribute start" },
        ["]x"] = { query = "@regex.outer", desc = "Next regex start" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold start" },
      },
      goto_next_end = {
        ["]\\"] = { query = "@comment.outer", desc = "Next comment end" },
        ["]["] = { query = "@class.outer", desc = "Next class end" },
        ["]A"] = { query = "@assignment.outer", desc = "Next assignment end" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
        ["]F"] = { query = "@frame.outer", desc = "Next frame (LaTeX) end" },
        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
        ["]M"] = { query = "@function.outer", desc = "Next method end" },
        ["]N"] = { query = "@number.inner", desc = "Next number end" },
        ["]P"] = { query = "@parameter.outer", desc = "Next parameter end" },
        ["]R"] = { query = "@return.outer", desc = "Next return end" },
        ["]T"] = { query = "@local.scope", query_group = "locals", desc = "Next TS scope end" },
        ["]V"] = { query = "@attribute.outer", desc = "Next attribute end" },
        ["]X"] = { query = "@regex.outer", desc = "Next regex end" },
        ["]Z"] = { query = "@fold", query_group = "folds", desc = "Next fold end" },
      },
      goto_previous_start = {
        ["[/"] = { query = "@comment.outer", desc = "Previous comment start" },
        ["[["] = { query = "@class.outer", desc = "Previous class start" },
        ["[a"] = { query = "@assignment.outer", desc = "Previous assignment start" },
        ["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
        ["[f"] = { query = "@frame.outer", desc = "Previous frame (LaTeX) start" },
        ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
        ["[m"] = { query = "@function.outer", desc = "Previous method start" },
        ["[n"] = { query = "@number.inner", desc = "Previous number start" },
        ["[p"] = { query = "@parameter.outer", desc = "Previous parameter start" },
        ["[r"] = { query = "@return.outer", desc = "Previous return start" },
        ["[t"] = { query = "@local.scope", query_group = "locals", desc = "Previous TS scope start" },
        ["[v"] = { query = "@attribute.outer", desc = "Previous attribute start" },
        ["[x"] = { query = "@regex.outer", desc = "Previous regex start" },
        ["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold start" },
      },
      goto_previous_end = {
        ["[\\"] = { query = "@comment.outer", desc = "Previous comment end" },
        ["[]"] = { query = "@class.outer", desc = "Previous class end" },
        ["[A"] = { query = "@assignment.outer", desc = "Previous assignment end" },
        ["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
        ["[F"] = { query = "@frame.outer", desc = "Previous frame (LaTeX) end" },
        ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
        ["[M"] = { query = "@function.outer", desc = "Previous method end" },
        ["[N"] = { query = "@number.inner", desc = "Previous number end" },
        ["[P"] = { query = "@parameter.outer", desc = "Previous parameter end" },
        ["[R"] = { query = "@return.outer", desc = "Previous return end" },
        ["[T"] = { query = "@local.scope", query_group = "locals", desc = "Previous TS scope end" },
        ["[V"] = { query = "@attribute.outer", desc = "Previous attribute end" },
        ["[X"] = { query = "@regex.outer", desc = "Previous regex end" },
        ["[Z"] = { query = "@fold", query_group = "folds", desc = "Previous fold end" },
      },
    },

    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["Al"] = { query = "@assignment.lhs", desc = "assignment lhs" },
        ["Ar"] = { query = "@assignment.rhs", desc = "assignment rhs" },
        ["a/"] = { query = "@comment.outer", desc = "comment" },
        ["aC"] = { query = "@call.outer", desc = "call" },
        ["aF"] = { query = "@frame.outer", desc = "frame" },
        ["aS"] = { query = "@statement.outer", desc = "statement" },
        ["aa"] = { query = "@assignment.outer", desc = "assignment" },
        ["ac"] = { query = "@class.outer", desc = "class" },
        ["af"] = { query = "@function.outer", desc = "function" },
        ["ai"] = { query = "@conditional.outer", desc = "conditional" },
        ["al"] = { query = "@loop.outer", desc = "loop" },
        ["an"] = { query = "@number.inner", desc = "number" },
        ["ap"] = { query = "@parameter.outer", desc = "parameter" },
        ["ar"] = { query = "@return.outer", desc = "return" },
        ["av"] = { query = "@attribute.outer", desc = "attribute" },
        ["ax"] = { query = "@regex.outer", desc = "regex" },
        ["i/"] = { query = "@comment.inner", desc = "inner comment" },
        ["iC"] = { query = "@call.inner", desc = "inner call" },
        ["iF"] = { query = "@frame.inner", desc = "inner frame" },
        ["iS"] = { query = "@scopename.inner", desc = "scopename" },
        ["ia"] = { query = "@assignment.inner", desc = "inner assignment" },
        ["ic"] = { query = "@class.inner", desc = "inner class" },
        ["if"] = { query = "@function.inner", desc = "inner function" },
        ["ii"] = { query = "@conditional.inner", desc = "inner conditional" },
        ["il"] = { query = "@loop.inner", desc = "inner loop" },
        ["in"] = { query = "@number.inner", desc = "number" },
        ["ip"] = { query = "@parameter.inner", desc = "inner parameter" },
        ["ir"] = { query = "@return.inner", desc = "inner return" },
        ["iv"] = { query = "@attribute.inner", desc = "inner attribute" },
        ["ix"] = { query = "@regex.inner", desc = "inner regex" },
      },
    },

    swap = {
      enable = true,
      swap_next = {
        ["<leader>mn"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>mp"] = "@parameter.inner",
      },
    },
  },
}

-- End of file.
