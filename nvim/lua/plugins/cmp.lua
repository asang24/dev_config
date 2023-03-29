local cmp_status_ok, cmp = pcall(require, "cmp")
	if not cmp_status_ok then
		return
	end

	local luasnip = require("luasnip")
    vim.opt.completeopt = "menu,menuone,noselect"

	require("luasnip.loaders.from_vscode").lazy_load()

	cmp.setup({
		enabled = function()
			if require("cmp.config.context").in_treesitter_capture("comment") == true
				or require("cmp.config.context").in_syntax_group("Comment")
			then
				return false
			else
				return true
			end
		end,

		preselect = cmp.PreselectMode.Item,
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		experimental = {
			ghost_text = true,
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				local lspkind_icons = {
					Text = "",
					Method = "",
					Function = "",
					Constructor = "",
					Field = "ﰠ",
					Variable = "",
					Class = "ﴯ",
					Interface = "",
					Module = "",
					Property = "ﰠ",
					Unit = "塞",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "",
					Color = "",
					File = "",
					Reference = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "פּ",
					Event = "",
					Operator = "",
					TypeParameter = " ",
					Robot = "ﮧ",
					Smiley = "ﲃ",
					Note = " ",

				}
				local meta_type = vim_item.kind
				-- load lspkind icons
				vim_item.kind = lspkind_icons[vim_item.kind] .. ""

				if entry.source.name == "emoji" then
					vim_item.kind = lspkind_icons["Smiley"]
					vim_item.kind_hl_group = "CmpItemKindEmoji"
				end

				vim_item.menu = ({
					buffer = "[Buffer]",
					nvim_lsp = meta_type,
					path = "[Path]",
					luasnip = "[LuaSnip]",
					cmp_tabnine = "[TN]",
					emoji = "[Emoji]",
					look = "[Dict]",
				})[entry.source.name]

				return vim_item
			end,
		},
        mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
            ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
            ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
            ["<C-e>"] = cmp.mapping.abort(), -- close completion window
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
		-- You can set mappings if you want
		-- mapping = insert_map,
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "nvim_lsp", priority = 50 },
			{ name = "luasnip", priority = 50 },
			{ name = "path", priority = 99 },
			{ name = "buffer", priority = 50, max_item_count = 5 },
			{ name = "emoji", priority = 50 },
			{ name = "nvim_lsp_signature_help", priority = 50 },
		},
    -- 根据文件类型补全
	cmp.setup.filetype({ "TelescopePrompt" }, {
		sources = cmp.config.sources({
            {name = 'buffer'}
        }),
	}),
    cmp.setup.filetype({ "vim", "markdown" }, {
		sources = cmp.config.sources({
            {name = 'buffer'}
        })
	}),
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            {name = 'buffer'}
        })
    }),
    -- 命令模式下输入 `/` 启用补全
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            {name = 'buffer'}
        })
    }),
   -- 命令模式下输入 `:` 启用补全
    -- cmp.setup.cmdline(':', {
    --     mapping = cmp.mapping.preset.cmdline(),
    --     sources = cmp.config.sources({{ name = 'path' }}, {{ name = 'cmdline' }})
    -- }),
})
