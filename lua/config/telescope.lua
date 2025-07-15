local telescope = require("telescope")

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			".git",
			"node_modules",
			"dist/",
			"build/",
			"target/",
			"%.lock",
			"%.cache",
			"obj/",
			"bin/",
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_cursor({
				-- even more opts
			}),
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			-- needed to exclude some files & dirs from general search
			-- when not included or specified in .gitignore
			find_command = {
				"rg",
				"--files",
				"--hidden",
				"--glob=!**/.git/*",
				"--glob=!**/.idea/*",
				"--glob=!**/.vscode/*",
				"--glob=!**/build/*",
				"--glob=!**/dist/*",
				"--glob=!**/yarn.lock",
				"--glob=!**/package-lock.json",
			},
		},
	},
})

telescope.load_extension("yank_history")
telescope.load_extension("file_browser")
telescope.load_extension("ui-select")

