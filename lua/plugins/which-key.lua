return {
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				plugins = {
					marks = false, -- Disable marks (e.g., `<leader>'`)
					registers = false, -- Disable registers (e.g., `<leader>r`)
					spelling = { enabled = false }, -- Disable spelling suggestions
					presets = {
						g = false, -- Disable all 'g' key mappings
						operators = false, -- Disable operator mappings (like `d`, `y`, `c`, etc.)
						motions = false, -- Disable motion mappings (like `w`, `b`, `e`, etc.)
						text_objects = false, -- Disable text object mappings (like `iw`, `aw`, etc.)
						windows = false, -- Disable window-related mappings (like `H`, `J`, `K`, `L`)
						nav = false, -- Disable navigation-related mappings (like `f`, `t`)
						z = false, -- Disable folding-related mappings (like `z`, `zz`)
					},
				},
			})

			require("which-key").add({
				{ "<leader>b", group = "buffer" },
				{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "File tree" },
				{ "<leader>r", "<cmd>Telescope registers<CR>", desc = "Registers" },
				{ "<leader>c", group = "Code" },
				{ "<leader>cq", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Quick fix" },
				{ "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
				{ "<leader>f", group = "Find" },
				{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
				{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
				{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
				{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },
				{ "<leader>t", group = "Telescope" },
				{ "<leader>tm", "<cmd>Telescope marks<CR>", desc = "Marks" },
				{ "<leader>tr", "<cmd>Telescope registers<CR>", desc = "Registers" },
				{ "<leader>tt", "<cmd>Telescope tags<CR>", desc = "Tags" },
				{ "<leader>q", group = "Quit" },
				{ "<leader>qq", "<cmd>qa<CR>", desc = "Quit" },
				{ "<leader>qa", "<cmd>wqa<CR>", desc = "Save all and quite" },
				{ "<leader>qx", "<cmd>qa!<CR>", desc = "Force quit" },
				{ "<leader>s", group = "Sessions" },
				{ "<leader>ss", "<cmd>SessionSearch<CR>", desc = "Session list" },
				{ "L", "<cmd>bnext<CR>", desc = "Next buffer" },
				{ "H", "<cmd>bprev<CR>", desc = "Previous buffer" },
				{ "g", group = "Go To" },
				{ "gb", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to Implementation" },
				{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition" },
				{ "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Find References" },
				{ "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Go to Type Definition" },
			})
		end,
	},
}
