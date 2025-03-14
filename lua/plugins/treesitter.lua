return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "typescript", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
    additional_vim_regex_highlighting = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["as"] = "@local.scope",
              ["ap"] = "@jsxattr.outer",
              ["at"] = "@jsxelem.outer",
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
              ['@class.outer'] = '<c-v>',
            },
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]x"] = "@jsxelem.outer", ["]e"] = "@export.stmt", ["]m"] = "@return.stmt"  },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]X"] = "@jsxelem.outer", ["]E"] = "@export.stmt" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[x"] = "@jsxelem.outer", ["[e"] = "@export.stmt", ["[m"] = "@return.stmt"  },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[X"] = "@jsxelem.outer", ["[E"] = "@export.stmt" },
          },
          lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {
              border = "rounded",
            },
            peek_definition_code = {
              ['<leader>df'] = "@function.outer",
              ['<leader>dF'] = "@class.outer",
            }
          }
        }
      }

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    commit = "ab0950c53d1ae04da8e488aa762b450d5241dca2",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  }
}
