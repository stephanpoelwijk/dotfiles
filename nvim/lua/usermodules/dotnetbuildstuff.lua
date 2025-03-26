local M = {}

local function update_quickfix_list(fileName)
	local file = io.open(fileName, "r")
	if not file then
		print("Could not open file " .. fileName)
		return
	end

	local quickfix_list = {}

	for line in file:lines() do
		-- Only matches build errors
		local filepath, lnum, col, text = line:match("^(.+)%((%d+),(%d+)%)%: error (.+)$")

		if filepath and lnum and col and text then
			text = text:match("^(.-)%s%[.+$")

			table.insert(quickfix_list, {
				filename = filepath,
				lnum = tonumber(lnum),
				col = tonumber(col),
				text = text,
			})
		end
	end

	io.close(file)

	vim.fn.setqflist(quickfix_list)
end

M.build = function()
	print("Building stuff")

	local logFileName = vim.fn.stdpath("data") .. "build.log"

	local cmd = string.format("dotnet build /flp:v=q /flp:logfile=%s", logFileName)

	vim.fn.jobstart(cmd, {
		on_exit = function(_, b, _)
			if b == 0 then
				print("Build succeeded")
			else
				print("Build failed")
				update_quickfix_list(logFileName)
				vim.cmd("copen")
			end

			os.remove(logFileName)
		end,
	})
end

return M
