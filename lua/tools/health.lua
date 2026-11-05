-- Health check for external programs, run with `:checkhealth tools`.

local tools = require("tools")

local M = {}

M.check = function()
  local health = vim.health
  local current_section

  for _, item in ipairs(tools.entries()) do
    local entry = item.entry

    if item.section ~= current_section then
      current_section = item.section
      health.start(current_section)
    end

    local exe = entry.exe == nil and entry.name or entry.exe
    local label = entry.name
    if exe and exe ~= entry.name then
      label = label .. " (" .. exe .. ")"
    end
    if entry.used_by then
      label = label .. ": " .. entry.used_by
    end

    if exe == false then
      health.info(label .. ": not checked")
    elseif vim.fn.executable(exe) == 1 then
      health.ok(label)
    else
      local advice = {}
      for installer, pkg in pairs(entry.pkg or {}) do
        table.insert(advice, installer .. ": " .. pkg)
      end
      table.sort(advice)
      local report = entry.optional and health.warn or health.error
      report(label .. ": executable not found", advice)
    end
  end
end

return M
