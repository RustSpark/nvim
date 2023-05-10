vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 配置模块导入环境
vim.opt.rtp:append(vim.env.SVIM_BASE_DIR or debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])"))

-- 加载设置
require("svim.settings")

-- 加载插件
require("svim.plugins")

-- 配置主题
local colorscheme = "hardhacker"
vim.g.colors_name = colorscheme
vim.cmd("colorscheme " .. colorscheme)

-- 配置nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()
require("nvim-web-devicons").setup()

-- 配置cmp
require("svim.cmp")

-- 配置内置terminal
local toggleterm = require("toggleterm")
toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	direction = "float",
	on_create = function(t)
    t:send("conda activate dev")
	end,
})

-- 配置注释
require("Comment").setup()

require("svim.keymappings")
