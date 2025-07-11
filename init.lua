vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.opt.clipboard = "unnamedplus"

local undodir = vim.fn.stdpath("data") .. "/.undo"

-- Create it if it doesn't exist
vim.fn.mkdir(undodir, "p")

-- Enable persistent undo
vim.opt.undofile = true
vim.opt.undodir = undodir

require("config.lazy")
require("config/keymaps")
require("telescope").load_extension("yank_history")
require("telescope").load_extension("file_browser")
