local M = {}

local quickfixUtil = require("usermodules.quickfixutil")

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
				quickfixUtil.update_quickfix_list(logFileName)
				vim.cmd("copen")
			end

			os.remove(logFileName)
		end,
	})
end

return M
