# reglist.nvim

A simple Neovim plugin to display the contents of registers in a floating window.

## ✨ Features

- View all registers and their contents in a floating window.
- Displays the type of each register.
- Customizable window position and appearance.
- Close the window with `q` or `<Esc>`.

## 📦 Installation

You can install this plugin using your favorite plugin manager.

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "shizukani-cp/reglist.nvim",
  config = function()
    require("reglist").setup({
      -- your configuration
    })
  end,
}
```

## 🚀 Usage

Open the register list window by running the following command:

```vim
:Reglist
```

To close the window, press `q` or `<Esc>`.

## ⚙️ Configuration

You can customize the plugin's behavior by calling the `setup` function.

Here is the default configuration:

```lua
require("reglist").setup({
  margin_col = 4,
  margin_row = 2,
  win_opts = {
    style = "minimal",
    border = "single",
  },
})
```

- `margin_col`: Left and right margins for the floating window.
- `margin_row`: Top and bottom margins for the floating window.
- `win_opts`: Options passed to `nvim_open_win`. See `:help nvim_open_win()` for details.

## License

This plugin is released under the MIT License. See [LICENSE](./LICENSE) for details.
