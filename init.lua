local uv = vim.loop
local path_sep = uv.os_uname().version:match("Windows") and "\\" or "/"
-- 配置模块导入环境
vim.opt.rtp:append(vim.env.SVIM_BASE_DIR)

-- 加载设置
require("svim.settings")

-- 加载插件
local plugin_data = {
	"theme-vim",
}
for _, value in ipairs(plugin_data) do
	local plugin_path = table.concat({ vim.env.SVIM_BASE_DIR, "plugins", value }, path_sep)
	vim.opt.rtp:append(plugin_path)
end

-- 配置主题
local colorscheme = "hardhacker"
vim.g.colors_name = colorscheme
vim.cmd("colorscheme " .. colorscheme)
