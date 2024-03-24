-- Check if notes plugin is already loaded
if vim.g.notes_loaded then
	return -- If loaded, exit to prevent reloading
end

-- Mark notes plugin as loaded
vim.g.notes_loaded = true

-- Running the setup function, this function will be called only once
if require("notes").is_setup_required() then
	require("notes").setup()
end

-- Create a user command named "Notes"
vim.api.nvim_create_user_command("Notes", function(opts)
	local args = opts.fargs
	-- Check if any arguments were provided
	if #args == 0 then
		-- Print error message if no arguments were provided
		print("Invalid command. Choose from write, find, get, or setup")
		return
	end
	-- Check the first argument to determine the action
	if args[1] == "write" then
		-- Call the write_notes function from the notes module
		require("notes").write_notes()
	elseif args[1] == "find" then
		-- Call the find_notes function from the notes module
		require("notes").find_notes()
	elseif args[1] == "get" then
		-- Call the get_notes function from the notes module
		require("notes").get_notes()
	elseif args[1] == "setup" then
		-- Call the setup function from the notes module and pass any additional arguments
		require("notes").setup()
	else
		-- Print error message if an invalid command was provided
		print("Invalid command: " .. args[1] .. ". Choose from write, find, get, or setup")
	end
end, { nargs = "*" })

-- Define key mappings for commonly used commands
vim.api.nvim_set_keymap("n", "<leader>nw", ":Notes write<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>nf", ":Notes find<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ng", ":Notes get<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ns", ":Notes setup<CR>", { noremap = true, silent = true })
