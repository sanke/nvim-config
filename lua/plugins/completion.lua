return {
	{
		"saghen/blink.cmp",
		build = "cargo build --release",
		version = "*",
		opts = {
			completion = { documentation = { auto_show = true } },
			keymap = {
				preset = "default",
				["<CR>"] = { "select_and_accept", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
		},
	},
}
