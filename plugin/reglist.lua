
-- reglist.nvim
--
-- A Neovim plugin to list registers and their values.

local api = vim.api

-- Create a command to open the register list.
api.nvim_create_user_command('Reglist', function() require('reglist').open() end, {})
