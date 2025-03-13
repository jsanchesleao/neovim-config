local state = {
  awk_code = nil,
  preview = nil,
}

function get_dimensions()
  local margin_width = 3 
  local margin_height = 2
  return {
    margin_width = margin_width,
    margin_height = margin_height,
    base_width = math.floor((vim.o.columns - (3 * margin_width)) / 3),
    base_height = vim.o.lines - (2 * margin_height),
  }
end

function open_script_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  local dimensions = get_dimensions()

  local win_config = {
    relative = "editor",
    width = dimensions.base_width,
    height = dimensions.base_height,
    col = dimensions.margin_width,
    row = dimensions.margin_height,
    style = "minimal",
    border = "rounded"
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  vim.cmd "set syntax=awk"

  if state.awk_code ~= nil then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, state.awk_code)
  end

  return { buf = buf, win = win }
end

function open_preview_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  local dimensions = get_dimensions()

  local win_config = {
    relative = "editor",
    width = dimensions.base_width * 2,
    height = dimensions.base_height,
    col = (dimensions.base_width * 2) + dimensions.base_width,
    row = dimensions.margin_height,
    style = "minimal",
    border = "rounded"
  }

  local win = vim.api.nvim_open_win(buf, false, win_config)
  return { buf = buf, win = win }
end

function execute_awk(current_buf, awk_buf, preview_buf)
  local awk_script = table.concat(vim.api.nvim_buf_get_lines(awk_buf, 0, -1, false), '\n')
  local target_text = table.concat(vim.api.nvim_buf_get_lines(current_buf, 0, -1, false), '\n')

  local tmp_file_name = os.tmpname()
  local script_file = io.open(tmp_file_name, 'w')
  script_file:write(awk_script, '\n')
  script_file:close()

  local result = vim.system({'awk', '-f', tmp_file_name}, {stdin = target_text}):wait()

  if result.code ~= 0 then
    vim.notify("awk: " .. result.stderr, vim.log.levels.ERROR)
  else
    vim.api.nvim_buf_set_lines(preview_buf, 0, -1, false, vim.split(result.stdout, '\n'))
  end

  os.remove(tmp_file_name)
end


function start_yawk()
  local current_buf = vim.api.nvim_get_current_buf()
  local awk_script = open_script_buffer()
  local awk_preview = open_preview_buffer()

  if state.preview ~= nil then
    vim.api.nvim_buf_set_lines(awk_preview.buf, 0, -1, false, state.preview)
  else
    vim.api.nvim_buf_set_lines(awk_preview.buf, 0, -1, false, vim.api.nvim_buf_get_lines(current_buf, 0, -1, false))
  end

  vim.bo[awk_preview.buf].filetype = vim.bo[current_buf].filetype

  vim.keymap.set('n', 'q', function()
    state.awk_code = vim.api.nvim_buf_get_lines(awk_script.buf, 0, -1, false)
    state.preview = vim.api.nvim_buf_get_lines(awk_preview.buf, 0, -1, false)
    vim.api.nvim_win_close(awk_preview.win, true)
    vim.api.nvim_win_close(awk_script.win, true)
  end, { buffer = awk_script.buf }) 

  vim.keymap.set('n', 'Q', function()
    state.awk_code = nil
    state.preview = nil
    vim.api.nvim_win_close(awk_preview.win, true)
    vim.api.nvim_win_close(awk_script.win, true)
  end, { buffer = awk_script.buf }) 

  vim.keymap.set({'n', 'i'}, '<c-x>', function()
    execute_awk(current_buf, awk_script.buf, awk_preview.buf)
  end, { buffer = awk_script.buf })

  vim.keymap.set({'n', 'i'}, '<c-s>', function()
    vim.api.nvim_buf_set_lines(current_buf, 0, -1, false, vim.api.nvim_buf_get_lines(awk_preview.buf, 0, -1, false))
    state.awk_code = nil
    state.preview = nil
    vim.api.nvim_win_close(awk_preview.win, true)
    vim.api.nvim_win_close(awk_script.win, true)
  end, { buffer = awk_script.buf })

  if state.awk_code == nil then
    vim.cmd "startinsert"
  end
end

function setup()
  vim.api.nvim_create_user_command('Yawk', start_yawk, { nargs = 0 })
end

return {
  setup = setup
}
