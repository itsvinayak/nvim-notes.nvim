local notes = {}

-- Function to get the path where notes will be saved
local function get_notes_path(path)
	if path then
		return path
	end
	local home = os.getenv("HOME")
	path = home .. "/.notes"
	return path
end

-- Function to prompt the user to input the Git URL for saving notes
local function get_git_url_to_save_notes()
	local git_url = vim.fn.input("Enter the git url to save notes: ")
	return git_url
end

-- Function to create a folder for saving notes and initialize Git repository
function notes.create_folder_to_save_notes(path, git_url)
	-- Get the notes directory path
	path = get_notes_path(path)
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

-- Function to set up notes environment
function notes.setup(args)
	-- if args is not provided, then set it to an empty table
	args = args or nil
	vim.g.notes_loaded = true
	-- Get the git URL and path from the arguments
	if args and args.git_url and args.path then
		notes.create_folder_to_save_notes(args.path, args.git_url)
		return
	end
	local git_url = args.git_url or vim.fn.input("Enter the git url to save notes: ")
	local path = args.path or vim.fn.input("Enter the path to save notes: ")
	notes.create_folder_to_save_notes(path, git_url)
end

-- Function to search for notes using Telescope plugin
function notes.get_notes()
	local path = get_notes_path()
	require("telescope.builtin").find_files({
		prompt_title = "Notes",
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
	-- Stage, commit, and push the new note to Git
	os.execute("git add " .. filename)
	os.execute("git commit -m 'Add note on " .. os.date("%m-%d-%H-%M-%S") .. "'")
	os.execute("git push")
end

return notes
