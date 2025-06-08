-- config file for neogit.

return {
  commit_editor = {
    kind = "auto",
  },
  git_services = {
      ["codeberg.org"] = "https://codeberg.org/${owner}/${repository}/compare/${branch_name}",
  },
  graph_style = "kitty",
  mappings = {
    rebase_editor = {
      -- Remove quick actions for rebase editor

      -- ["b"] = "Break",
      ["b"] = false,
      -- ["d"] = "Drop",
      ["d"] = false,
      -- ["e"] = "Edit",
      ["e"] = false,
      -- ["f"] = "Fixup",
      ["f"] = false,
      -- ["p"] = "Pick",
      ["p"] = false,
      -- ["q"] = "Close",
      ["q"] = false,
      -- ["r"] = "Reword",
      ["r"] = false,
      -- ["s"] = "Squash",
      ["s"] = false,
      -- ["x"] = "Execute",
      ["x"] = false,
    },
  },
}
