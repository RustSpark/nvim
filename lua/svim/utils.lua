local M = {}

function M.get_path_sep()
	local uv = vim.loop
	return uv.os_uname().version:match("Windows") and "\\" or "/"
end

return M
