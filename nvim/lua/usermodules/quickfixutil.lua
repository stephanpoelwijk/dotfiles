local M = {}

M.update_quickfix_list = function(fileName)
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

return M
