local defaut_options = {
	number = true,
	cursorline = true,
	tabstop = 2,
	relativenumber = true,
	expandtab = true,
	shiftwidth = 2,
}

for key, value in pairs(defaut_options) do
	vim.opt[key] = value
end
