return {
	{
		"olimorris/codecompanion.nvim",
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = {
							name = "copilot",
							model = "gpt-4o",
						},
					},
				},
			})
		end,
	},
}
