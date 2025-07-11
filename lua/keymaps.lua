local wk = require("which-key")

wk.add({
	{ "<leader><leader>", "<cmd>Telescope find_files<CR>", desc = "Find file" },
	{ "<leader>f", group = "Find" },
	{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find file" },
	{ "<leader>fe", "<cmd>Telescope file_browser<CR>", desc = "File explorer" },
	{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
	{ "<leader>c", group = "Code" },
	{ "<leader>p", "<cmd>Telescope yank_history<CR>", desc = "Yank history" },
	{
		"<leader>aa",
		function()
			require("harpoon"):list():add()
		end,
		desc = "Harpoon",
	},
	{
		"<leader>al",
		function()
			toggle_telescope(require("harpoon"):list())
		end,
		desc = "List",
	},
	{
		"<leader>cf",
		function()
			require("conform").format()
		end,
		desc = "Format",
	},
	{},
})
