return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Make sure plenary is installed
    config = function()
      require("diffview").setup({
        keymaps = {
          disable_defaults = false,
        },
      })
    end,
  },
}
