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

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = 80,
    height = 20,
    row = 10,
    col = 10,
    style = 'minimal',
    border = 'single',
  })
end

return M
