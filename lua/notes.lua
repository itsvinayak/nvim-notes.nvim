local utils = require 'utils'
local notes = {}

-- Default configuration
local default_config = {}
default_config = {}
default_config.path = utils.get_notes_path()
default_config.log_file = os.getenv 'HOME' .. '/.config/nvim/log/notes.log'
default_config.log_level = 'INFO'
default_config.log_enabled = false

notes.config = default_config

-- Function to setup the notes plugin
function notes.setup(user_config)
  -- Merge user-provided config with the default configuration
  notes.config = utils.merge_config(default_config, user_config)
  -- Create a folder to save notes
  utils.log('Creating folder to save notes' .. notes.config.path, notes.config.log_level, notes.config.log_enabled)
  notes.create_folder_to_save_notes()
end

-- Function to create a folder for saving notes
function notes.create_folder_to_save_notes()
  -- Get the notes directory path
  local path = notes.config.path
  -- Create the directory if it doesn't exist
  if vim.fn.isdirectory(path) == 0 then
    utils.log('Creating directory : ', path)
    vim.fn.mkdir(path, 'p')
  end
end

-- Function to search for notes using Telescope plugin
function notes.get_notes()
  local path = notes.config.path
  require('telescope.builtin').find_files {
    prompt_title = 'Get Notes',
    cwd = path,
  }
end

-- Function to search within notes using Telescope plugin
function notes.find_notes()
  local path = notes.config.path
  require('telescope.builtin').live_grep {
    prompt_title = 'Find Notes',
    cwd = path,
  }
end

-- Function to write new notes
function notes.write_notes()
  local path = notes.config.path
  -- Generate a filename with current date and time
  local filename = path .. '/note_' .. os.date '%m-%d-%H-%M-%S' .. '.txt'
  notes.create_folder_to_save_notes()
  -- Open a new file for writing notes
  vim.cmd('edit ' .. filename)
end

return notes
