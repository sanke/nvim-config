require('user.options')

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

require('user.keymaps')
