return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			require("cmp").setup({
				sources = {
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
				},
				-- other options like window, mapping, etc. can follow
			})
		end,
	},
}
