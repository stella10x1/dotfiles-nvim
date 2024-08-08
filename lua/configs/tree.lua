-- config file for nvim-tree.

return {
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
}

-- End of file.
