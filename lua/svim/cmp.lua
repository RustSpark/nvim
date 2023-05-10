local utils = require("svim.utils")
local cmp = require("cmp")
local sources = {
	{ name = "buffer" },
	{ name = "path" },
}
local source_names = {
	buffer = "(Buffer)",
	path = "(Path)",
}
local duplicates = {
	buffer = 1,
	path = 1,
}
local confirm_opts = {
	behavior = cmp.ConfirmBehavior.Replace,
	select = false,
}

for _, source in ipairs(sources) do
	local name = source.name
	vim.opt.rtp:append(
		table.concat({ vim.env.SVIM_BASE_DIR, "plugins", "cmp-" .. name, "after" }, utils.get_path_sep())
	)
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local name = entry.source.name
			vim_item.menu = source_names[name]
			vim_item.dup = duplicates[name]
			return vim_item
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	sources = sources,
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
		["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-y>"] = cmp.mapping({
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- elseif luasnip.expand_or_locally_jumpable() then
			-- 	luasnip.expand_or_jump()
			-- elseif jumpable(1) then
			-- 	luasnip.jump(1)
			elseif has_words_before() then
				-- cmp.complete()
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			-- elseif luasnip.jumpable(-1) then
			-- 	luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				local opts = vim.deepcopy(confirm_opts) -- avoid mutating the original opts below
				local is_insert_mode = function()
					return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
				end
				if is_insert_mode() then -- prevent overwriting brackets
					opts.behavior = cmp.ConfirmBehavior.Insert
				end
				if cmp.confirm(opts) then
					return -- success, exit early
				end
			end

			fallback() -- if not exited early, always fallback
		end),
	}),
})
