return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{
				"giuxtaposition/blink-cmp-copilot",
			},
		},
		build = "cargo build --release",
		version = "*",
		config = function()
			require("blink.cmp").setup({
				keymap = {
					["<CR>"] = { "select_and_accept", "fallback" },
				},
			})
		end,
		opts = {
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { "lsp", "path", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "Copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
		},
	},
}
