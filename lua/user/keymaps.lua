-- Keymaps configuration for Neovim
-- This file defines custom keybindings for various plugins and core features

local keymap = vim.keymap.set
local utils = require("user.functions")
local chat = require("CopilotChat")

-- Disable space as a key (acts as leader)
keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- General Keymaps
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Window management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })
keymap("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- Toggle nvim-tree file explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

-- Telescope (fuzzy finder) keymaps
local builtin = require("telescope.builtin")

-- Search files in the current directory
keymap("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })

-- Search for a string (requires ripgrep)
keymap("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })

-- Show open buffers in normal mode
keymap("n", "<leader>b", function()
	require("telescope.builtin").buffers({
		initial_mode = "normal",
		sort_mru = true,
		ignore_current_buffer = true,
	})
end, { desc = "Telescope Buffers (Normal Mode)" })

-- Search through help tags
keymap("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Search through your recent files
keymap("n", "<leader>fr", builtin.oldfiles, { desc = "Telescope recent files" })

-- Show diagnostics for the current line
keymap("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Show workspace diagnostics with Telescope
keymap("n", "<leader>xX", function()
	require("telescope.builtin").diagnostics()
end, { desc = "Workspace Diagnostics" })

keymap("n", "<leader>xx", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "File Diagnostics" })

-- Format code using Conform
keymap("n", "<leader>cf", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Code Format" })

-- Window navigation shortcuts
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- LSP Refactoring / Navigation
keymap("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Code Rename" })
keymap("n", "<leader>cs", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
keymap("n", "<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
keymap("n", "gr", function()
	require("telescope.builtin").lsp_references()
end, { desc = "LSP: [G]oto [R]eferences" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })

-- Show all open buffers
keymap("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, { desc = "Find Buffers" })

-- Clipboard history using yanky.nvim
vim.keymap.set("n", "<leader>p", function()
	require("telescope").extensions.yank_history.yank_history({
		initial_mode = "normal",
	})
end, { desc = "Clipboard History" })

-- Copilot suggestion navigation
vim.keymap.set("i", "<C-.>", function()
	require("copilot.suggestion").next()
	require("lualine").refresh()
end, { desc = "Trigger Copilot Suggestion" })

-- Toggle Copilot Chat window
vim.keymap.set("n", "<leader>rc", chat.toggle, { desc = "Copilot Chat Toggle" })

-- Smart quit (prompts to save unsaved buffers)
vim.keymap.set("n", "<leader>qq", utils.smart_quit, { desc = "Smart Quit with Save Prompt" })

-- Comment toggling (line and visual selection)
vim.keymap.set("n", "<leader>cc", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Comment line" })
vim.keymap.set(
	"v",
	"<leader>cc",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Comment selection" }
)

-- Select session using persistence.nvim
keymap("n", "<leader>qs", function()
	require("persistence").select()
end, { desc = "Select Session" })

-- Marks

vim.keymap.set("n", "<leader>m", "<cmd>Telescope marks<cr>", { desc = "List Bookmarks" })
