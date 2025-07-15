-- General options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Undo directory
local undodir = vim.fn.stdpath("data") .. "/.undo"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir

-- Keymaps
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })