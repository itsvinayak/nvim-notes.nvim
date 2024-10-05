if vim.g.notes_loaded then
  return -- If loaded, exit to prevent reloading
end

-- Mark notes plugin as loaded
vim.g.notes_loaded = true

-- Create a user command named "Notes" that can be used to interact with the notes plugin
vim.api.nvim_create_user_command('Notes', function(opts)
  local args = opts.fargs
  -- Check if any arguments were provided
  if #args == 0 then
    -- Print error message if no arguments were provided
    print 'Invalid command. Choose from write, find or get'
    return
  end
  -- Check the first argument to determine the action
  if args[1] == 'write' then
    -- Call the write_notes function from the notes module
    require('notes').write_notes()
  elseif args[1] == 'find' then
    -- Call the find_notes function from the notes module
    require('notes').find_notes()
  elseif args[1] == 'get' then
    -- Call the get_notes function from the notes module
    require('notes').get_notes()
  elseif args[1] == 'setup' then
    -- Extract configuration arguments if provided (e.g., log level, path)
    local config = {}
    -- Simple handling for optional key-value pairs (key=value format)
    for i = 2, #args do
      local key, value = string.match(args[i], '([^=]+)=([^=]+)')
      if key and value then
        config[key] = value
      end
    end
    -- Call setup function with the config
    require('notes').setup(config)
  elseif args[1] == 'help' then
    -- Print help message if help command was provided
    print 'Notes plugin commands:'
    print '  :Notes write - Write a new note'
    print '  :Notes find - Find notes by title'
    print '  :Notes get - Get a list of all notes'
    print '  :Notes setup key=value - Setup the notes plugin (optional config)'
  else
    -- Print error message if an invalid command was provided
    print('Invalid command: ' .. args[1] .. '. Choose from write, find or get')
  end
end, { nargs = '*' })

-- Define key mappings for commonly used commands
vim.api.nvim_set_keymap('n', '<leader>nw', ':Notes write<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ':Notes find<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ng', ':Notes get<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ns', ':Notes setup<CR>', { noremap = true, silent = true })

-- WhichKey mappings
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
