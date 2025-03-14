return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { 'hrsh7th/nvim-cmp' },
    lazy = false,
    opts = {
      snip_env = {
        s = function(...)
          local ls = require('luasnip')
          local snip = ls.s(...)
          table.insert(getfenv(2).ls_file_snippets, snip)
        end,
        parse = function(...)
          local ls = require('luasnip')
          local snip = ls.parser.parse_snippet(...)
          table.insert(getfenv(2).ls_file_snippets, snip)
        end,
      }
    },
    config = function(opts)
      local ls = require('luasnip')
      ls.setup(opts)
      vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true, desc = "Expand snippet" })
      vim.keymap.set({ "i", "s" }, "<S-Right>", function() ls.jump(1) end,
        { silent = true, desc = "Jump to next snippet position" })
      vim.keymap.set({ "i", "s" }, "<S-Left>", function() ls.jump(-1) end,
        { silent = true, desc = "Jump to previous snippet position" })
      vim.keymap.set({ "i", "s" }, "<S-Up>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true, desc = "Next snippet choice" })
      vim.keymap.set({ "i", "s" }, "<S-Down>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end, { silent = true, desc = "Previous snippet choice" })
    end,
  },
}

