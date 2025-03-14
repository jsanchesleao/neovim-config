return {
  'hrsh7th/nvim-cmp',
  dependencies = { 'hrsh7th/cmp-nvim-lsp', 'saadparwaiz1/cmp_luasnip' },
  opts = function()
    local cmp = require('cmp')
		require('cmp_nvim_lsp').default_capabilities()
    return {
      snippet = {
				expand = function(args)
				  require('luasnip').lsp_expand(args.body)
				end,
      },
			window = {
        completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
      },
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			}, {
				{ name = 'buffer' },
			})
    }
  end,
}
