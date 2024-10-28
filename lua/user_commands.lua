vim.api.nvim_create_user_command("SearchReplace", function(opts)
  -- Recursive search for pattern
  vim.cmd.vimgrep("/" .. opts.fargs[1] .. "/gj **/*")
  -- Print or update all matches depending of the presense of a second paramter
  if opts.fargs[2] then
    vim.cmd.cfdo("%s/" .. opts.fargs[1] .. "/" .. opts.fargs[2] .. "/g | update")
  else
    vim.cmd.clist()
  end
end, { nargs = "+" })
