local notes = {}

-- Function to get the path where notes will be saved
local function get_notes_path()
	local home = os.getenv("HOME")
	local path = home .. "/.notes"
	return path
end

-- Function to prompt the user to input the Git URL for saving notes
local function get_git_url_to_save_notes()
	local git_url = vim.fn.input("Enter the git url to save notes: ")
	return git_url
end

-- Function to create a folder for saving notes and initialize Git repository
function notes.create_folder_to_save_notes(git_url)
	-- Get the notes directory path
	local path = get_notes_path()
	-- Create the directory if it doesn't exist
	if not vim.fn.isdirectory(path) then
		vim.fn.mkdir(path, "p")
	else
		print("Notes directory already exists.")
		return
	end

	-- Prompt user for Git URL if not provided
	local git_url = git_url or get_git_url_to_save_notes()
	if git_url == "" then
		print("Skipping saving to git.")
		return
	end

	-- Change directory to the notes folder and initialize Git
	os.execute("cd " .. path)
	os.execute("git init")
	os.execute("git remote add origin " .. git_url)
	os.execute("git pull origin master --allow-unrelated-histories")
	-- Change back to the original directory
	os.execute("cd -")
end

function notes.is_setup_required()
	local path = get_notes_path()
	if not vim.fn.isdirectory(path) then
		return true
	end
	return false
end

-- Function to set up notes environment
function notes.setup()
	-- Get the git URL and path from the arguments
	local git_url = vim.fn.input("Enter the git url to save notes: ")
	print("Git URL: ", git_url)
	notes.create_folder_to_save_notes(git_url)
	vim.g.notes_loaded = true
end

-- Function to search for notes using Telescope plugin
function notes.get_notes()
	local path = get_notes_path()
	require("telescope.builtin").find_files({
		prompt_title = "Get Notes",
		cwd = path,
	})
end

-- Function to search within notes using Telescope plugin
function notes.find_notes()
	local path = get_notes_path()
	require("telescope.builtin").live_grep({
		prompt_title = "Find Notes",
		cwd = path,
	})
end

-- Function to write new notes
function notes.write_notes()
	local path = get_notes_path()
	-- Generate a filename with current date and time
	local filename = path .. "/note_" .. os.date("%m-%d-%H-%M-%S") .. ".txt"
	-- Open a new file for writing notes
	vim.cmd("edit " .. filename)
	vim.api.nvim_command([[
	    autocmd BufWritePost * lua
		local filename = vim.fn.expand("<afile>")
		os.execute("git add " .. filename)
		os.execute("git commit -m 'Add note on " .. os.date("%m-%d-%H-%M-%S") .. "'")
		os.execute("git push --all")
	]])
end

return notes
