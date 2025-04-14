return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		keys = { { "<C-/>", "<cmd>ToggleTerm<CR>", "Toggle terminal" } },
		opts = {
			open_mapping = [[<C-/>]],
		},
	},
}
