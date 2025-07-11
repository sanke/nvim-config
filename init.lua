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
require("keymaps")
require("telescope").load_extension("yank_history")
require("telescope").load_extension("file_browser")
require("mason").setup()
-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

local conf = require("telescope.config").values
function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
