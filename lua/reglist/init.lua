-- reglist.nvim
--
-- A Neovim plugin to list registers and their values.

local M = {}

-- @public
function M.setup()
  -- No setup needed at the moment.
end

-- @public
function M.open()
  local registers = {
    '"', '-', '_', '*', '+', '#', '%', ':', '.', '/',
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
    'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
    'u', 'v', 'w', 'x', 'y', 'z',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
  }

  local lines = {}
  table.insert(lines, ' Registers')
  table.insert(lines, '')
  for _, reg in ipairs(registers) do
    local value = vim.fn.getreg(reg)
    value = value:gsub('\n', '\\n')
    local value_type = vim.fn.getregtype(reg)
    table.insert(lines, string.format('  %s (%s) %s', reg, value_type, value))
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local margin_col = 4
  local margin_row = 2

  local editor_width = vim.api.nvim_get_option('columns')
  local editor_height = vim.api.nvim_get_option('lines')

  local win_width = editor_width - (margin_col * 2)
  local win_height = editor_height - (margin_row * 2)

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = margin_row,
    col = margin_col,
    style = 'minimal',
    border = 'single',
  })

  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<Cmd>close<CR>', { noremap = true, silent = true })
end

return M
