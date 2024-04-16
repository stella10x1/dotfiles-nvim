return {
  "lervag/vimtex",
  -- vimtex is mostly a ftplugin and therefore naturally "lazy loaded".
  lazy = false,
  config = function()
    vim.g["vimtex_view_method"] = "zathura"
    -- enable offline documentation
    vim.g["vimtex_doc_handlers"] = { "vimtex#doc#handlers#texdoc" }
    -- disable completion, because it is handled by LSP (texlab)
    vim.g["vimtex_complete_enabled"] = 0
  end,
}
