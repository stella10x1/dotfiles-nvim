local ts = vim.treesitter
local parsers = require "nvim-treesitter.parsers"

local parser = parsers.get_parser()
local tree = parser:parse()[1]
local root = tree:root()
local lang = parser:lang()

local M = {}

local function get_node_text(node)
  return ts.get_node_text(node, 0):match("lang:%s%a%a"):gsub("lang: ", "")
end

M.parse_lang = function()
  -- Tree-Sitter query string
  local qs = "(minus_metadata) @fm"
  local query = ts.query.parse(lang, qs)

  local frontmatter_node = nil
  local fm_lang = nil

  for _, matches, _ in query:iter_matches(root, 0) do
    -- it should only exist one match
    for _, match in ipairs(matches) do
      frontmatter_node = match
    end
  end

  if pcall(get_node_text, frontmatter_node) then
    fm_lang = get_node_text(frontmatter_node)
  end

  return fm_lang
end

return M
