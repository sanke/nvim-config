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
		init = function()
			local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"
			vim.opt.runtimepath:prepend(lspConfigPath)
		end,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("lspconfig")["roslyn"].setup({
				capabilities = capabilities,
			})
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
