-- Keymaps configuration for Neovim
-- This file defines custom keybindings for various plugins and core features

local keymap = vim.keymap.set
local utils = require("user.functions")
local chat = require("CopilotChat")
local wk = require("which-key")

-- Disable space as a key (acts as leader)
keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- General Keymaps
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Window navigation shortcuts
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Copilot suggestion navigation
keymap("i", "<C-.>", function()
  require("/copilot.suggestion").next()
  require("lualine").refresh()
end, { desc = "Trigger Copilot Suggestion" })

-- Which-key mappings
wk.add({
  -- Leader key groups
  {
    "<leader>b",
    function()
      require("telescope.builtin").buffers({
        initial_mode = "normal",
        sort_mru = true,
        ignore_current_buffer = true,
      })
    end,
    icon = "",
    desc = "Buffers",
  },
  { "g", group = "General", icon = "󱘞" },
  { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
  { "gr", require("telescope.builtin").lsp_references, desc = "Go to References" },
  { "gi", vim.lsp.buf.implementation, desc = "Go to Implementation" },
  { "gt", vim.lsp.buf.type_definition, desc = "Go to Type Definition" },
  { "go", vim.lsp.buf.declaration, desc = "Go to Declaration" },
  -- {
  --   "gs",
  --   function()
  --     require("telescope.builtin").lsp_document_symbols({
  --       symbols = {
  --         "Function",
  --         "Method",
  --         "Property",
  --         "Field",
  --         "Variable" -- Optional: adds local/global variables
  --       },
  --     })
  --   end,
  --   desc = "Document Symbols"
  -- },
  { "gs", "<cmd>Telescope aerial<cr>", desc = "Toggle Aerial" },
  { "gS", require("telescope.builtin").lsp_dynamic_workspace_symbols, desc = "Workspace Symbols" },
  { "<leader>c", group = "Code" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
  {
    "<leader>cf",
    function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end,
    desc = "Format",
  },
  { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
  { "<leader>e", ":NvimTreeToggle<CR>", icon = "", desc = "File Explorer" },
  { "<leader>f", group = "Find" },
  {
    "<leader>fb",
    function()
      require("telescope.builtin").buffers()
    end,
    icon = "",
    desc = "Buffers",
  },
  { "<leader>fg", require("telescope.builtin").live_grep, desc = "Live Grep" },
  { "<leader>fh", require("telescope.builtin").help_tags, desc = "Help Tags" },
  { "<leader>fr", require("telescope.builtin").oldfiles, desc = "Recent Files" },
  { "<leader>m", "<cmd>Telescope marks<cr>", icon = "󱪾", desc = "Marks" },
  { "<leader>n", "<leader>nh", desc = "Clear Search Highlights" },
  {
    "<leader>p",
    function()
      require("telescope").extensions.yank_history.yank_history({
        initial_mode = "normal",
      })
    end,
    icon = "",
    desc = "Clipboard History",
  },
  { "<leader>q",  group = "Quit/Session" },
  { "<leader>qq", utils.smart_quit,      desc = "Smart Quit" },
  {
    "<leader>qs",
    function()
      require("persistence").select()
    end,
    desc = "Select Session",
  },
  { "<leader>r", desc = "Copilot", icon = "" },
  { "<leader>rc", chat.toggle, desc = "Chat", icon = "󰭹" },
  { "<leader>s", group = "Split", icon = "󰕪" },
  { "<leader>se", "<C-w>=", desc = "Equalize Splits" },
  { "<leader>sh", "<C-w>s", desc = "Split Horizontal" },
  { "<leader>sv", "<C-w>v", desc = "Split Vertical" },
  { "<leader>sx", ":close<CR>", desc = "Close Split" },
  { "<leader>x", group = "Diagnostics" },
  { "<leader>xx", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "File Diagnostics" },
  {
    "<leader>xX",
    function()
      require("telescope.builtin").diagnostics()
    end,
    desc = "Workspace Diagnostics",
  },
  { "<leader>u", "<cmd>Telescope undo<cr>", icon = "", desc = "Undo History" },
  -- Non-leader mappings
  { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" },
  { "<leader><leader>", require("telescope.builtin").find_files, desc = "Find Files" },
  -- Comment toggling
  { "<leader>c", group = "Code", mode = "v" },
  {
    "<leader>cc",
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    desc = "Comment",
    mode = "v",
  },
})

-- Comment line in normal mode
keymap("n", "<leader>cc", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comment" })

-- Normal mode shortcut for nh
keymap("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear Highlights" })

-- LSP documentation scrolling
keymap("n", "<C-f>", function()
  vim.lsp.buf.scroll(4)
end, { desc = "Scroll Docs Down" })

keymap("n", "<C-b>", function()
  vim.lsp.buf.scroll(-4)
end, { desc = "Scroll Docs Up" })
