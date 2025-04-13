return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			require("neo-tree").setup({
				window = {
					position = "right",
					mappings = {
						["l"] = "open",
						["h"] = "close_node",
						["P"] = {
							"toggle_preview",
							config = {
								use_float = false,
								-- use_image_nvim = true,
								-- title = 'Neo-tree Preview',
							},
						},
					},
				},
			})
		end,
	},
}
