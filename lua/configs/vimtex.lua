-- plugin file for vimtex.

vim.g.vimtex_view_method = "zathura"
-- enable offline documentation
vim.g.vimtex_doc_handlers = { "vimtex#doc#handlers#texdoc" }
-- disable completion, because it is handled by LSP (texlab)
vim.g.vimtex_complete_enabled = 0

-- End of file.
