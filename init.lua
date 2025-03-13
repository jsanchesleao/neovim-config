require('config.lazy')
require('jef.floating')
require('jef.yawk').setup()

-- set defaults
vim.cmd "set tabstop=2"
vim.cmd "set shiftwidth=2"
vim.cmd "set expandtab"
-- vim.cmd "colorscheme tokyonight-night"
vim.cmd "colorscheme cyberdream"
vim.cmd "set number"
vim.cmd "set relativenumber"
vim.cmd "set foldlevel=99"

-- helpful remaps
vim.keymap.set({'i', 't'}, 'kj', '<Esc>', { noremap = true })
vim.keymap.set('n', ';', ':', { noremap = true })
vim.keymap.set('n', '<c-e>', '10<c-e>', { noremap = true })
vim.keymap.set('n', '<c-y>', '10<c-y>', { noremap = true })
vim.keymap.set('n', '<leader><tab>', '<cmd>bd<cr>', { noremap = true })
vim.keymap.set('n', '<leader>gg', '<cmd>silent !tmux-popup-run lazygit<cr>', { noremap = true, desc = "Lazy Git" })
vim.keymap.set('n', '<leader>gy', '<cmd>silent !tmux-popup-run yazi<cr>', { noremap = true, desc = "Lazy Git" })

-- lsp commands
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>k', function() 
  vim.lsp.buf.hover({ border = "rounded" })
end)

-- terminal commands
vim.keymap.set('n', '<c-space>', '<cmd>silent !tmux-popup<cr>')
vim.keymap.set('n', '<leader>x', '<cmd>silent !tmux-popup-session<cr>')
vim.keymap.set('n', '<leader>gb', '<cmd>silent !tmux-popup-run tig blame %<cr>')

-- neovide
if vim.g.neovide then
  vim.api.nvim_command "cd /Users/dasilvasanchesle/projects/webmobile-pwa"

  vim.g.neovide_position_animation_lenght = 0.01
  vim.g.neovide_scroll_animation_length = 0.1
end
