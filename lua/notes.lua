local notes = {}

local function get_notes_path()
	local home = os.getenv("HOME")
	local path = home .. "/.notes"
	return path
end

local function get_git_url_to_save_notes()
	local git_url = vim.fn.input("Enter the git url to save notes: ")
	return git_url
end

function notes.create_folder_to_save_notes()
	local git_url = get_git_url_to_save_notes()
	local path = get_notes_path()
	-- get current directory
	if not vim.fn.isdirectory(path) then
		vim.fn.mkdir(path, "p")
	end
	if git_url == "" then
		return true -- skip saving to git
	end
	os.execute("cd " .. path)
	-- save to git
	os.execute("git remote add origin " .. git_url)
	os.execute("git pull")
	-- back to the original directory
	os.execute("cd -")
	return true
end

function notes.setup()
	local path = get_notes_path()
	vim.fn.mkdir(path, "p")
	vim.g.NOTES_PATH = path
	notes.create_folder_to_save_notes()
	vim.g.notes_loaded = true
end

function notes.get_notes()
	local path = get_notes_path()
	require("telescope.builtin").find_files({
		prompt_title = "Notes",
		cwd = path,
	})
end

function notes.find_notes()
	local path = get_notes_path()
	require("telescope.builtin").live_grep({
		prompt_title = "Find Notes",
		cwd = path,
	})
end

function notes.write_notes()
	local path = get_notes_path()
	local filename = path .. "/note_" .. os.date("%m-%d-%H-%M-%S") .. ".txt"
	vim.cmd("e " .. filename)
	os.execute("git add " .. filename)
	os.execute("git commit -m 'Add note on " .. os.date("%m-%d-%H-%M-%S") .. "'")
	os.execute("git push")
end

return notes
