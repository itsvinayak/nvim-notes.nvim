# Notes.nvim


Notes.nvim is a simple Neovim plugin for managing notes. It integrates with Telescope.nvim to help you create, search, and manage notes easily within Neovim

## Features

- Create Notes: Quickly create notes with :Notes write.
- Search Notes: Search through your notes with :Notes find using Telescope.
- List Notes: Retrieve a list of all notes with :Notes get.
- Custom Setup: Configure note paths, logging, and more with :Notes setup.


Installation (Using Lazy.nvim)

Add the following lines to your init to install the plugin with Lazy.nvim.lua:

### Step-by-Step Installation

- Add Notes.nvim to your Lazy.nvim setup:

```lua
require("lazy").setup({
  {
    'itsvinayak/nvim-notes.nvim',  -- Replace with your GitHub username
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Add Telescope as a dependency
      'folke/which-key.nvim'            -- Add WhichKey as a dependency
    },
    config = function()
      require('notes').setup {
        -- Optional configurations
        path = '~/.my_notes',         -- Custom path for notes
        log_enabled = true,           -- Enable logging
        log_level = 'INFO'            -- Set log level to INFO
      }

      -- Setup WhichKey mappings
      if pcall(require, 'which-key') then
        require('which-key').register({
          ['<leader>n'] = {
            name = 'Notes',
            w = { 'Write a new note', ':Notes write<CR>' },
            f = { 'Find notes by title', ':Notes find<CR>' },
            g = { 'Get a list of all notes', ':Notes get<CR>' },
            s = { 'Setup the notes plugin', ':Notes setup<CR>' },
          },
        }, { prefix = '' })
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
- :Notes setup [key=value]
  Configures the plugin (e.g., paths, logging) using key-value pairs.


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
  path = '~/.notes',              -- Directory where notes are saved
  log_file = '~/.config/nvim/log/notes.log', -- Log file location
  log_level = 'INFO',              -- Log level: INFO, DEBUG, ERROR, etc.
  log_enabled = false,             -- Enable or disable logging
}
```

## Dependencies

- Neovim 0.5+: Make sure you're running Neovim 0.5 or higher.
- Telescope.nvim: This plugin requires Telescope to perform note searches.

## License

This project is licensed under the MIT License. See the LICENSE file for more information.
