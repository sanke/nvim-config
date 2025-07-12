local wk = require("which-key")

wk.add({
	{ "<leader><leader>", "<cmd>Telescope find_files<CR>", desc = "Find file" },
	{ "<leader>f", group = "Files" },
	{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find file" },
	{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
	{ "<leader>fe", "<cmd>Telescope file_browser<CR>", desc = "File explorer" },
	{ "<leader>ft", "<cmd>NvimTreeOpen<CR>", desc = "Tree view" },
	{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
	{ "<leader>p", "<cmd>Telescope yank_history<CR>", desc = "Yank history" },
	{ "<leader>a", group = "Harppon" },
	{
		"<leader>aa",
		function()
			require("harpoon"):list():add()
		end,
		desc = "Add",
	},
	{
		"<leader>al",
		function()
			toggle_telescope(require("harpoon"):list())
		end,
		desc = "List",
	},
	{ "<leader>c", group = "Code" },
	{
		"<leader>cf",
		function()
			require("conform").format()
		end,
		desc = "Format",
	},
	{ "<leader>ce", "<cmd>Telescope diagnostics<CR>", desc = "Errors" },
	{ "<leader>cp", "<cmd>CodeCompanionChat<CR>", desc = "Copilot chat" },
	{},
})
