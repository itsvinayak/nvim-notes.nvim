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
  if args[1] == 'write' or args[1] == 'w' then
    -- Call the write_notes function from the notes module
    require('notes').write_notes()
  elseif args[1] == 'find' or args[1] == 'f' then
    -- Call the find_notes function from the notes module
    require('notes').find_notes()
  elseif args[1] == 'get' or args[1] == 'g' then
    -- Call the get_notes function from the notes module
    require('notes').get_notes()
  elseif args[1] == 'help' or args[1] == 'h' then
    -- Print help message if help command was provided
    print 'Notes plugin commands:'
    print '  :Notes write - Write a new note'
    print '  :Notes find - Find notes by title'
    print '  :Notes get - Get a list of all notes'
  else
    -- Print error message if an invalid command was provided
    print('Invalid command: ' .. args[1] .. '. Choose from write, find or get')
  end
end, { nargs = '*' })

-- Define key mappings for commonly used commands
vim.api.nvim_set_keymap('n', '<leader>nw', ':Notes write<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ':Notes find<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ng', ':Notes get<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nh', ':Notes help<CR>', { noremap = true, silent = true })
