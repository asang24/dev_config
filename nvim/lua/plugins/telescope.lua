-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

-- configure telescope
telescope.setup({
  -- configure custom mappings
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
	    horizontal = {
            prompt_position = "bottom",
		    preview_width = 0.55,
		    results_width = 0.8
		},
		vertical = { mirror = false },
		    width = 0.87,
		    height = 0.80,
		    preview_cutoff = 120
	},
    sorting_strategy = "ascending",
	prompt_prefix = "> ",
	selection_caret = " ",
	winblend = 0,
    mappings = {
        i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-c>"] = actions.close,
            ["<Down>"] = actions.move_selection_next,
		    ["<Up>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
        },
        n = {
            ["<esc>"] = actions.close,
		    ["<CR>"] = actions.select_default,
		    ["<C-c>"] = actions.close,
		    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
		    ["<C-j>"] = actions.move_selection_next,
		    ["<C-k>"] = actions.move_selection_previous,
		    ["<Down>"] = actions.move_selection_next,
		    ["<Up>"] = actions.move_selection_previous,

	    }
    },
  },
})

telescope.load_extension("fzf")
