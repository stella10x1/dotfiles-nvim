-- Print the packages of all registered external programs for an installer.
--
-- Usage: nvim -l ~/.config/nvim/scripts/packages.lua [installer]
--
-- Example (Arch Linux):
--   nvim -l ~/.config/nvim/scripts/packages.lua pacman | sudo pacman -S --needed -

local installer = arg[1] or "pacman"
local packages, missing = require("tools").packages(installer)

for _, pkg in ipairs(packages) do
  io.stdout:write(pkg, "\n")
end

if #missing > 0 then
  io.stderr:write("No ", installer, " package for: ", table.concat(missing, ", "), "\n")
end
