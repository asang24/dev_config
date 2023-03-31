local wilder_status, wilder = pcall(require, "wilder")
if not wilder_status then
	return
end

wilder.setup({
	modes = { ":", "/", "?" },
	next_key = 0,
	previous_key = 0,
	reject_key = 0,
	accept_key = 0,
})

-- 设置样式
wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
		-- 设置特定高亮
		highlights = {
			accent = "WilderAccent",
			selected_accent = "WilderSelectedAccent",
		},
		highlighter = wilder.basic_highlighter(),
		left = { " ", wilder.popupmenu_devicons() }, -- 左侧加入icon
		right = { " ", wilder.popupmenu_scrollbar() }, -- 右侧加入滚动条
		border = "rounded",
		max_height = 16, -- 最大高度限制 因为要计算上下 所以17支持最多15个选项
	}))
)

-- 设置高亮
vim.api.nvim_set_hl(0, "WilderAccent", { fg = "#5f87ff" })
vim.api.nvim_set_hl(0, "WilderSelectedAccent", { fg = "#5f87ff", bg = "#4e4e4e" })

vim.api.nvim_set_keymap(
	"c",
	"<tab>",
	[[wilder#in_context() ? wilder#next() : '<tab>']],
	{ noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
	"c",
	"<Down>",
	[[wilder#in_context() ? wilder#next() : '<down>']],
	{ noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
	"c",
	"<up>",
	[[wilder#in_context() ? wilder#previous() : '<up>']],
	{ noremap = true, expr = true }
)
