return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				pickers = {
					find_files = {
						initial_mode = "normal",
					},
					buffers = {
						initial_mode = "normal",
					},
				},
				defaults = {
					mappings = {
						n = {
							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["q"] = actions.close,
						},
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
