local opt = vim.opt

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set space as leader key
vim.g.mapleader = " "

opt.number = true          -- Show line numbers
opt.relativenumber = true  -- Relative line numbers (great for jumping)
opt.tabstop = 2            -- Number of spaces a tab counts for
opt.shiftwidth = 2         -- Size of an indent
opt.expandtab = true       -- Use spaces instead of tabs
opt.smartindent = true     -- Insert indents automatically
opt.termguicolors = true   -- True color support
opt.cursorline = true      -- Highlight the current line

opt.clipboard = "unnamedplus"

-- allow scrolling past end of file
opt.scrolloff = 15
vim.opt.virtualedit = "onemore"

opt.termguicolors = true

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false, -- Turn off the text at the end of the line
  float = {
    border = "rounded", -- Add a nice rounded border to the popup
    source = "always",  -- Show which LSP the error is coming from
  },
})

-- Show diagnostics in a floating window on hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- Decrease updatetime for faster response (default is 4000ms)
opt.updatetime = 300


-- Undo
opt.undofile = true

-- Set the directory where undo history will be stored
-- This keeps your project folders clean
local undodir = vim.fn.stdpath("data") .. "/vim-undo"
opt.undodir = undodir

-- Create the directory if it doesn't exist
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

-- auto save
-- local autosave = vim.api.nvim_create_augroup("autosave", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost", "BufLeave" }, {
-- 	group = autosave,
-- 	pattern = "*",
-- 	callback = function()
-- 		-- Only save if the buffer has been modified and is a real file
-- 		if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
-- 			vim.cmd("silent! update")
-- 		end
-- 	end,
-- })
--

-- fixes blank line at the bottom
opt.laststatus = 3
opt.cmdheight = 0

-- enter insert mode when terminal is open
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  pattern = "term://*",
  command = "startinsert",
})
