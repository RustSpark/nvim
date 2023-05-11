local K = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true, nowait = true }

local mappings = {
	n = {
		{ "<C-h>", "<C-w>h" },
		{ "<C-l>", "<C-w>l" },
		{ "<C-j>", "<C-w>j" },
		{ "<C-k>", "<C-w>k" },
		{ "<leader>/", "<Plug>(comment_toggle_linewise_current)" },
		{ "<leader>w", "<cmd>w!<cr>" },
		{ "<leader>h", "<cmd>nohlsearch<cr>" },
		{ "<leader>c", "<cmd>bd<cr>" },
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>" },
	},
	x = {
		{ "<", "<gv" },
		{ ">", ">gv" },
		{ "/", "<Plug>(comment_toggle_linewise_visual)" },
	},
}

for key, value in pairs(mappings) do
	for _, mapping in ipairs(value) do
		K(key, mapping[1], mapping[2], opt)
	end
end
