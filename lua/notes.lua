local utils = require 'utils'
local notes = {}

-- default configuration
local default_config = {}
default_config = {}
default_config.path = utils.get_notes_path()
default_config.log_level = 'info'
default_config.log_enabled = false
default_config.filetype = 'md'

notes.config = default_config

-- function to setup the notes plugin
function notes.setup(user_config)
  if pcall(require, 'telescope') == false then
    utils.log('telescope is not installed. please install it to use notes plugin', 'error', true)
    return
  end
  -- merge user-provided config with the default configuration
  notes.config = utils.merge_config(default_config, user_config)
  -- create a folder to save notes
  utils.log('creating folder to save notes' .. notes.config.path, notes.config.log_level, notes.config.log_enabled)
  notes.create_folder_to_save_notes()
end

-- function to create a folder for saving notes
function notes.create_folder_to_save_notes()
  -- get the notes directory path
  local path = vim.fn.expand(notes.config.path)
  -- create the directory if it doesn't exist
  if vim.fn.isdirectory(path) == 0 then
    if not vim.fn.mkdir(path, 'p') then
      vim.notify('failed to create directory for notes ' .. path)
      utils.log('failed to create directory : ', path, 'error', true)
    end
    utils.log('created directory : ', path)
    vim.notify('created directory for notes ' .. path)
  end
end

-- function to search for notes using telescope plugin
function notes.get_notes()
  local path = notes.config.path
  require('telescope.builtin').find_files {
    prompt_title = 'get notes',
    cwd = path,
  }
end

-- function to search within notes using telescope plugin
function notes.find_notes()
  local path = notes.config.path
  require('telescope.builtin').live_grep {
    prompt_title = 'find notes',
    cwd = path,
  }
end

-- function to write new notes
function notes.write_notes()
  local path = notes.config.path
  local filetype = notes.config.filetype
  -- generate a filename with current date and time
  local filename = path .. '/note_' .. os.date '%m-%d-%h-%m-%s' .. '.' .. filetype
  notes.create_folder_to_save_notes()
  -- open a new file for writing notes
  vim.cmd('edit ' .. filename)
end

return notes
