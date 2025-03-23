local M = {}

M.starts_with = function(s, s_start)
	return vim.fn.match(s, "^" .. s_start) == 0
end

M.ends_with = function(s, s_end)
	return vim.fn.match(s, s_end .. "$") > 0
end

return M
