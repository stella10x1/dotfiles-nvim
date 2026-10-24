-- Functions to query the registry of external programs (lua/tools/registry.lua).

local registry = require "tools.registry"

local M = {}

M.sections = { "lsp", "formatter", "linter", "tools" }

-- Return the names of all LSP servers, e.g. for vim.lsp.enable().
M.lsp = function()
  local names = {}
  for _, entry in ipairs(registry.lsp) do
    table.insert(names, entry.name)
  end
  return names
end

-- Build a filetype -> names table from a registry section.
local by_ft = function(section)
  local result = {}
  for _, entry in ipairs(registry[section]) do
    for _, ft in ipairs(entry.ft or {}) do
      result[ft] = result[ft] or {}
      table.insert(result[ft], entry.name)
    end
  end
  return result
end

-- Return formatters_by_ft for conform.nvim.
M.formatters_by_ft = function()
  return by_ft "formatter"
end

-- Return linters_by_ft for nvim-lint.
M.linters_by_ft = function()
  return by_ft "linter"
end

-- Return all entries of the registry with their section, in registry order.
M.entries = function()
  local result = {}
  for _, section in ipairs(M.sections) do
    for _, entry in ipairs(registry[section]) do
      table.insert(result, { section = section, entry = entry })
    end
  end
  return result
end

-- Return the sorted, deduplicated package names for an installer (e.g.
-- "pacman") and the names of entries without a package for that installer.
M.packages = function(installer)
  local seen, packages, missing = {}, {}, {}
  for _, item in ipairs(M.entries()) do
    local pkg = (item.entry.pkg or {})[installer]
    if pkg then
      if not seen[pkg] then
        seen[pkg] = true
        table.insert(packages, pkg)
      end
    else
      table.insert(missing, item.entry.name)
    end
  end
  table.sort(packages)
  return packages, missing
end

return M
