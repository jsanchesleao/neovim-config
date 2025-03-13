return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>tf', '<cmd>Telescope find_files<CR>', desc = 'file finder' },
    { '<leader>tt', '<cmd>Telescope<CR>', desc = 'telescope default' },
    { '<leader>td', '<cmd>Telescope lsp_definitions<CR>', desc = 'LSP definitions finder' },
    { '<leader>ti', '<cmd>Telescope lsp_implementations<CR>', desc = 'LSP implementations finder' },
    { '<leader>tr', '<cmd>Telescope lsp_references<CR>', desc = 'LSP implementations finder' },
    { '<C-p>', '<cmd>Telescope git_files<CR>', desc = 'git file finder' },
    { '/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'current buffer fuzzy finder' },
  }
}
