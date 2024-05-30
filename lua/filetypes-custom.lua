vim.filetype.add({
  filename = {
    ["ansible.cfg"] = "dosini",
  },
  pattern = {
    -- [[
    -- Patterns for match ansible project specific files, e. g. all .yaml and .yml 
    -- files inside a folder path, which contains `host_vars`, `group_vars` or
    -- `roles` will be matched as yaml.ansible file. 
    --
    -- playbook and inventory files can have arbitrary strings between `playbook` 
    -- and `.yaml`. This allows to add multiple playbooks or inventories.
    --
    -- Example matches:
    --
    --   * playbook.yaml
    --   * inventory.yml
    --   * playbook.test.yaml
    --   * playbook0randomtext.yaml
    --   * inventory500.yaml
    -- ]]
    ['.*/host_vars/.*%.ya?ml'] = "yaml.ansible",
    ['.*/group_vars/.*%.ya?ml'] = "yaml.ansible",
    ['.*/roles/.*%.ya?ml'] = "yaml.ansible",
    ['playbook.*%.ya?ml'] = "yaml.ansible",
    ['inventory.*%.ya?ml'] = "yaml.ansible",
    -- ansible role directories
    ['.*/defaults/.*%.ya?ml'] = "yaml.ansible",
    ['.*/handlers/.*%.ya?ml'] = "yaml.ansible",
    ['.*/meta/.*%.ya?ml'] = "yaml.ansible",
    ['.*/tasks/.*%.ya?ml'] = "yaml.ansible",
    ['.*/vars/.*%.ya?ml'] = "yaml.ansible",
  },
})
