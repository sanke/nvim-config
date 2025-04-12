require("neo-tree").setup({
	window = {
		mappings = {
			["l"] = "open",
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
