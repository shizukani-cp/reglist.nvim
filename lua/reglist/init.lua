-- reglist.nvim
--
-- A Neovim plugin to list registers and their values.

local M = {}

-- Default configuration
local config = {
  margin_col = 4,
  margin_row = 2,
  win_opts = {
    style = 'minimal',
    border = 'single',
  },
}

-- @public
-- Merges user config with defaults
function M.setup(user_config)
  user_config = user_config or {}
  config = vim.tbl_deep_extend('force', config, user_config)
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

  local editor_width = vim.api.nvim_get_option('columns')
  local editor_height = vim.api.nvim_get_option('lines')

  local win_width = editor_width - (config.margin_col * 2)
  local win_height = editor_height - (config.margin_row * 2)

  local win_opts = {
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = config.margin_row,
    col = config.margin_col,
  }
  win_opts = vim.tbl_deep_extend('force', win_opts, config.win_opts)

  local win = vim.api.nvim_open_win(buf, true, win_opts)

  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<Cmd>close<CR>', { noremap = true, silent = true })
end

return M