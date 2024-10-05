local utils = {}

-- Logger function to log messages to the log file
function utils.log(message, level, enabled)
  if not enabled then
    return
  end
  level = level or 'INFO' -- Default log level is INFO
  local log_message = string.format('[%s] [%s]: %s\n', os.date '%Y-%m-%d %H:%M:%S', level, message)

  -- Append log message to the log file
  local file = io.open(log_file, 'a')
  if file then
    file:write(log_message)
    file:close()
  else
    vim.notify('Unable to write to log file: ' .. log_file, vim.log.levels.ERROR)
  end
end

-- Function to merge user-provided config with the default config
function utils.merge_config(default_config, user_config)
  return vim.tbl_deep_extend('force', default_config, user_config or {})
end

-- Function to get the path where notes will be saved
function utils.get_notes_path()
  local home = os.getenv 'HOME'
  local path = home .. '/.notes'
  return path
end

return utils
