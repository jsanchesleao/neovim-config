
function open_window(opts)
  opts = opts or {}

  -- sizes
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- position
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- bindings
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>q!<cr>', { noremap = true })

  -- window config
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded"
  }

  -- create window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

vim.api.nvim_create_user_command('JefFloat', function()
  open_window()
  vim.cmd "terminal"
end, {})
