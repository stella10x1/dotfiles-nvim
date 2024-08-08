-- config file for nvim-cmp.

local cmp = require "cmp"

return {
  completion = {
    completeopt = "menuone,preview,noselect",
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").jumpable(1) then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
}

-- End of file.
