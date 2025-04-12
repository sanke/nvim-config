local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

require("config.options")

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

require("mini.pairs").setup()

require("mason").setup()
require("config.conform")
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "rust_analyzer", "markdown" },
})

require("lspconfig").rust_analyzer.setup({})
require("config.lazyline")
require("bufferline").setup({})

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

require("config.tree")
require("config.keys")
require("config.tree")

require("which-key").register({
	["<leader>b"] = { name = "buffer" },
	["g"] = { name = "Go To" },
	["<leader>f"] = { name = "file" },
	["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
	["gb"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation" },
	["gt"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to Type Definition" },
	["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Find References" },
	["<leader>f"] = {
		name = "Find", -- Group for finding files
		f = { "<cmd>Telescope find_files<CR>", "Find Files" }, -- Find files
		g = { "<cmd>Telescope live_grep<CR>", "Live Grep" }, -- Live grep
		b = { "<cmd>Telescope buffers<CR>", "Buffers" }, -- List buffers
		h = { "<cmd>Telescope help_tags<CR>", "Help Tags" }, -- Help tags
	},
	["<leader>t"] = {
		name = "Telescope", -- Another group for more Telescope commands
		t = { "<cmd>Telescope tags<CR>", "Tags" }, -- Find tags
		m = { "<cmd>Telescope marks<CR>", "Marks" }, -- Find marks
		r = { "<cmd>Telescope registers<CR>", "Registers" }, -- Registers
	},
})

vim.api.nvim_set_keymap("n", "q", ":lclose<CR>", { noremap = true, silent = true })
require("telescope").setup()
