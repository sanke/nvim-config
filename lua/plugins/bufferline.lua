return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local buffer_ok, bufferline = pcall(require, "bufferline")
			if not buffer_ok then
				return
			end
			bufferline.setup({
				options = {
					diagnostics = "nvim_lsp",
					-- offsets = {
					-- 	{
					-- 		filetype = "NvimTree",
					-- 		text = "File Explorer",
					-- 		highlight = "Directory",
					-- 		separator = true, -- use a "true" to enable the default, or set your own character
					-- 	},
					-- },
				},
			})
		end,
	},
}
