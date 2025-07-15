require("mini.files").setup({
	options = {
		use_as_default_explorer = false,
	},
})

require("mini.diff").setup({
	options = {
		use_icons = true,
	},
	config = function()
		local diff = require("mini.diff")
		diff.setup({
			-- Disabled by default
			source = diff.gen_source.none(),
		})
	end,
})
