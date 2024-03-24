if vim.g.notes_loaded then
	return
end

vim.g.notes_loaded = true

vim.api.nvim_create_user_command("Notes", function(opts)
	local args = opts.fargs
	if #args == 0 then
		print("Invalid command choose from write, find, create")
		return
	end
	if args[1] == "write" then
		require("notes").write_notes()
	elseif args[1] == "find" then
		require("notes").find_notes()
	elseif args[1] == "get" then
		require("notes").get_notes()
	elseif args[1] == "setup" then
		require("notes").setup(args)
	else
		print("Invalid command " .. args[1] .. "choose from write, find, create")
	end
end, { nargs = "*" })

--- key mappings
vim.api.nvim_set_keymap("n", "<leader>nw", ":Notes write<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>nf", ":Notes find<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>nc", ":Notes create<CR>", { noremap = true, silent = true })
