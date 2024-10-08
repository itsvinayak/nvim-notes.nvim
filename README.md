# nvim-notes.nvim
[![Lua Format](https://github.com/itsvinayak/nvim-notes.nvim/actions/workflows/stylua.yml/badge.svg)](https://github.com/itsvinayak/nvim-notes.nvim/actions/workflows/stylua.yml)

![nvim-notes](images/nvim-notes.nvim.png)

nvim-notes is a simple Neovim plugin for managing notes. It integrates with Telescope.nvim to help you create, search, and manage notes easily within Neovim



## Features

- Create Notes: Quickly create notes with :Notes write.
- Search Notes: Search through your notes with :Notes find using Telescope.
- List Notes: Retrieve a list of all notes with :Notes get.
- Custom Setup: Configure note paths, logging, and more with :Notes setup.


## Installation (Using Lazy.nvim)

Add the following lines to your init to install the plugin with Lazy.nvim.lua:


- Add nvim-notes to your Lazy.nvim setup:

```lua
require("lazy").setup({
  {
    'itsvinayak/nvim-notes.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Add Telescope as a dependency
      'folke/which-key.nvim'           -- Add WhichKey as a dependency (optional)
    },
    config = function()
      require('notes').setup {
        -- Optional configurations
        path = '~/.my_notes',         -- Custom path for notes (default is '~/.notes')
        log_enabled = true,           -- Enable logging (default is false)
        log_level = 'INFO',           -- Set log level to INFO 
        filetype = 'md'              -- Sets the notes filetype default is 'md'
      }

      -- Setup WhichKey mappings using `add`
      if pcall(require, 'which-key') then
        local wk = require 'which-key'

        -- Corrected mappings using the new `add` method
        wk.add({
          ["<leader>n"] = { name = "Notes" }, -- Group name for notes
          
          ["<leader>nw"] = { ":Notes write<CR>", "Write a new note" },
          ["<leader>nf"] = { ":Notes find<CR>", "Find notes by title" },
          ["<leader>ng"] = { ":Notes get<CR>", "Get a list of all notes" },
        })
      end
    end
  },
})
```
- Synchronize Plugins: After adding the above, run:

```
:Lazy sync
```
## Commands
- :Notes write
  Opens a new buffer to create a note. The note is saved in the specified notes directory.
- :Notes find
  Searches for notes using Telescope.
- :Notes get
  Lists all the notes in the notes directory.


## Key Mappings

You can add key mappings to your init.lua or Neovim configuration to make working with the plugin easier:

```lua
vim.api.nvim_set_keymap('n', '<leader>nw', ':Notes write<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ':Notes find<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ng', ':Notes get<CR>', { noremap = true, silent = true })
```

## Configuration

The plugin comes with default settings, which you can customize during setup:

```lua
require('notes').setup {
  path = '~/.notes',               -- Directory where notes are saved
  log_level = 'INFO',              -- Log level: INFO, DEBUG, ERROR, etc.
  log_enabled = false,             -- Enable or disable logging
  filetype = 'txt',                      -- Sets the notes filetype
}
```

## Dependencies

- Neovim 0.5+: Make sure you're running Neovim 0.5 or higher.
- Telescope.nvim: This plugin requires Telescope to perform note searches.

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://itsvinayak.github.io/"><img src="https://avatars.githubusercontent.com/u/33996594?v=4?s=100" width="100px;" alt="vinayak"/><br /><sub><b>vinayak</b></sub></a><br /><a href="#code-itsvinayak" title="Code">💻</a> <a href="#doc-itsvinayak" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://www.linkedin.com/in/mi-connell/"><img src="https://avatars.githubusercontent.com/u/14168559?v=4?s=100" width="100px;" alt="Michael Connell"/><br /><sub><b>Michael Connell</b></sub></a><br /><a href="#doc-MiConnell" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/GeorgiChochev"><img src="https://avatars.githubusercontent.com/u/117806460?v=4?s=100" width="100px;" alt="Georgi Chochev"/><br /><sub><b>Georgi Chochev</b></sub></a><br /><a href="#code-GeorgiChochev" title="Code">💻</a> <a href="#doc-GeorgiChochev" title="Documentation">📖</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

## License

This project is licensed under the GNU License. See the LICENSE file for more information.
