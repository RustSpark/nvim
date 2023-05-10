local utils = require("svim.utils")
local plugin_data = {
	"theme-vim",
	"nvim-tree.lua",
	"nvim-web-devicons",
	"toggleterm.nvim",
	"Comment.nvim",
  "nvim-cmp",
  "cmp-buffer",
  "cmp-path",
}

for _, value in ipairs(plugin_data) do
	local plugin_path = table.concat({ vim.env.SVIM_BASE_DIR, "plugins", value }, utils.get_path_sep())
	vim.opt.rtp:append(plugin_path)
end
