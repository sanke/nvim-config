require('user.options')

local utils = require("user.functions")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("user.plugins")

vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_ls")
vim.lsp.enable("csharp_ls")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- If the argument is a directory
    if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
      -- Wipe the directory buffer
      vim.api.nvim_buf_delete(0, { force = true })
      -- Open Snacks Dashboard
      require("snacks").dashboard.open()
    end
  end,
})


-- Set up an autocommand to pull diagnostics when csharp_ls attaches
local csharp_diag_group = vim.api.nvim_create_augroup("CSharpDiagnostics", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = csharp_diag_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client.name == "csharp_ls" then
      -- Trigger an immediate pull when we first connect
      vim.defer_fn(function()
        utils.pull_workspace_diagnostics()         -- Assuming you added the 'silent' flag
      end, 500)                                  -- Slight delay to let the server initialize
    end
  end,
})

require('user.keymaps')
