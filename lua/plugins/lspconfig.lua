return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').ts_ls.setup({
        handlers = {
          ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
        }
      })

      require('lspconfig').pylsp.setup({})
    end,
  },
  {
    'j-hui/fidget.nvim',
    opts = {},
  }
}
