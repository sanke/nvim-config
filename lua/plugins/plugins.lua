return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					rust = { "rustfmt" },
				},
			})
		end,
		dependencies = { "mason.nvim", "nvim-tree/nvim-web-devicons" },
		lazy = true,
		cmd = "ConformInfo",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			require("which-key").setup({})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("auto-session").setup({})
		end,
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		},
	},
	{
		"gbprod/yanky.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"giuxtaposition/blink-cmp-copilot",
		dependencies = { "github/copilot.vim" },
	},
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		opts = {
			-- your configuration comes here; leave empty for default settings
		},
	},
}
