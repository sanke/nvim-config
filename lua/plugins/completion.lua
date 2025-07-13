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
--			keymap = {
--				preset = "default",
--				["<CR>"] = { "select_and_accept", "fallback" },
--			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
		},
	},
}

