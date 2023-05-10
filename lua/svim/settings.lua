local defaut_options = {
  fileencoding = "utf-8",
	number = true,
	cursorline = true,
	tabstop = 2,
	relativenumber = true,
	expandtab = true,
	shiftwidth = 2,
	-- guifont = "ComicShannsMono Nerd Font Mono:h12",
	-- guifont = "CodeNewRoman Nerd Font Mono:h12",
  guifont = "Monaco NFM:h10",
  termguicolors = true,
}

for key, value in pairs(defaut_options) do
	vim.opt[key] = value
end
