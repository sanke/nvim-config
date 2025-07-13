return {
	{
		"williamboman/mason.nvim",
		config = function()
			local mason = require("mason")
			mason.setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		init = function()
			local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"
			vim.opt.runtimepath:prepend(lspConfigPath)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local masonConfig = require("mason-lspconfig")
			masonConfig.setup()
		end,
	},
}
