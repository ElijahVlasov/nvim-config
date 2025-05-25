-- WIP
local function create_scratch_execute_buffer()
	-- Create a new scratch buffer
	local current_buf = vim.api.nvim_get_current_buf()
	local buf = vim.api.nvim_create_buf(false, false)

	vim.api.nvim_buf_set_name(buf, "🐗🐗🐗🐗🐗🐗🐗")
	vim.cmd("buffer " .. buf)
	vim.bo.filetype = "lua"
	-- Create buffer-local Run command
	vim.api.nvim_buf_create_user_command(buf, "Run", function()
		-- Get all lines from buffer
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		local content = table.concat(lines, "\n")
		local path = "/tmp/script.lua"
		local cmd = "source " .. path
		local file = io.open(path, "w")
		if file == nil then
			error("Cannot create a tmp file")
		end
		file:write(content)
		file:close()
		vim.cmd(cmd)
	end, {})
end

-- Create global command to make scratch buffer
vim.api.nvim_create_user_command("LuaTmp", create_scratch_execute_buffer, {})
