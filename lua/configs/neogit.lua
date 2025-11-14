-- config file for neogit.

return {
  commit_editor = {
    kind = "auto",
  },
  git_services = {
    ["git.10x1.eu"] = {
        pull_request = "https://${host}/${owner}/${repository}/compare/${branch_name}",
        commit = "https://${host}/${owner}/${repository}/commit/${oid}",
        tree = "https://${host}/${owner}/${repository}/src/branch/${branch_name}",
      },
    ["git.pulsar.rocks"] = {
      pull_request = "https://${host}/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
      commit = "https://${host}/${owner}/${repository}/-/commit/${oid}",
      tree = "https://${host}/${owner}/${repository}/-/tree/${branch_name}?ref_type=heads",
    },
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
