return {
  -- The File Tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function on_tree_attach(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- 1. Load default mappings first
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
      end

      require("nvim-tree").setup({
        on_attach = on_tree_attach, -- Tell Nvim-tree to use our keys
        hijack_netrw = false,
        view = {
          float = {
            enable = true,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * 0.5
              local window_h = screen_h * 0.5
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
              return {
                border = "rounded",
                relative = "editor",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
          width = function()
            return math.floor(vim.opt.columns:get() * 0.5)
          end,
        },
        renderer = {
          group_empty = true, -- Compact folders that only contain one folder
        },
        filters = {
          dotfiles = false, -- Set to true to hide .git, .DS_Store, etc.
        },
      })
    end,
  },
  -- LSP
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case", -- Change this to "--ignore-case" for strict case-insensitivity
          },
          mappings = {
            i = {
              -- Use <C-j> and <C-k> to navigate the results list in insert mode
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
            },
          },
          devicons = true,
        },
      })
    end,
  },
  -- Symbol search and outline
  { "nvim-tree/nvim-web-devicons", opts = {} },
  {
    'stevearc/aerial.nvim',
    opts = {
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
        "Property",
        "Field",
      },
      backends = { "lsp", "treesitter", "markdown" },
      layout = {
        min_width = 30,
        default_direction = "float",
      },
      show_guides = true,
      float = {
        border = "rounded",
        relative = "editor",
      },
    },

    config = function(_, opts)
      require("aerial").setup(opts)
      require("telescope").load_extension("aerial")
    end,
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        -- A list of parser names, or "all"
        ensure_installed = { "lua", "vim", "vimdoc", "rust", "bash" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        highlight = {
          enable = true, -- This enables the superior Treesitter highlighting
        },
      })
    end,
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Load when you save a file
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
      },
      -- Uncomment this if you want "Format on Save"
      -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<C-/>]], -- This represents Ctrl + / in most terminals
        shading_factor = 2,
        direction = "float",      -- You can use 'horizontal', 'vertical', or 'float'
        float_opts = {
          border = "curved",
        },
      })
    end,
  },
  -- Nice rename refactor
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        enabled = true,
        border = "rounded",
        relative = "cursor", -- Makes the rename box appear at your cursor
      },
    },
  },
  -- Clippoard view
  {
    "gbprod/yanky.nvim",
    dependencies = { "kkharji/sqlite.lua" }, -- Optional: for persistent history after restart
    config = function()
      require("yanky").setup({
        ring = {
          history_length = 100,
          storage = "shada", -- Uses Neovim's internal storage (easy) or "sqlite"
          sync_with_numbered_registers = true,
          cancel_event = "update",
        },
        system_clipboard = {
          sync_with_ring = true, -- This ensures system copy = yanky copy
        },
        highlight = {
          on_put = true, -- Flashes the text when you paste (very helpful)
          on_yank = true,
          timer = 200,
        },
        picker = {
          select = {
            action = nil, -- default: selection puts it in the register
          },
          telescope = {
            use_default_mappings = true, -- Enter will select and close
          },
        },
      })

      -- Load the telescope extension
      require("telescope").load_extension("yank_history")
    end,
  },
  -- Undo history
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("undo")
    end,
  },
  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init()
    end,
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Connection to LSP
      "hrsh7th/cmp-buffer",   -- Buffer completions (words in file)
      "hrsh7th/cmp-path",     -- File path completions
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),            -- Manually trigger completion
          ["<C-e>"] = cmp.mapping.abort(),                   -- Close menu
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept suggestion
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- Prioritize LSP completions
          { name = "buffer" },   -- Words from the current file
          { name = "path" },     -- File system paths
        }),
      })
    end,
  },
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- We enable suggestions for Ghost Text
        suggestion = {
          enabled = true,
          auto_trigger = true, -- Disable automatic ghost text
          debounce = 75,
          keymap = {
            accept = "<C-a>",  -- Alt + l to accept the suggestion
            next = false,      -- Alt + j to see next suggestion
            prev = false,      -- Alt + k to see previous
            dismiss = "<C-e>", -- Ctrl + e to close ghost text
          },
        },
        panel = { enabled = true },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "AndreM222/copilot-lualine",
    },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = "|",
          section_separators = { left = "", right = "" },
          globalstatus = true, -- Single bar at the bottom even with splits
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { { "filename", path = 1 }, "branch" },
          lualine_c = { "diff", "diagnostics" },
          lualine_x = {
            {
              "copilot",
              -- This handles the loading spinner and status colors
              symbols = {
                status = {
                  icons = {
                    enabled = " ",
                    sleep = " ",
                    disabled = " ",
                    warning = " ",
                    unknown = " ",
                  },
                  hl = {
                    enabled = "#a6e3a1",  -- Green
                    sleep = "#89b4fa",    -- Blue
                    disabled = "#f38ba8", -- Red
                    warning = "#fab387",  -- Orange
                  },
                },
                spinners = require("copilot-lualine.spinners").dots,
                interval = 100,
              },
              show_colors = true,
            },
            "encoding",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
        },
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load this first before other plugins
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",         -- latte, frappe, macchiato, mocha
        transparent_background = true, -- Great for blurred terminal backgrounds
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
        },
        custom_highlights = function(colors)
          return {
            -- This removes the black background from the completion menu
            Pmenu = { bg = "NONE" },
            PmenuSel = { bg = colors.surface0, fg = "NONE" },

            -- This fixes the borders and background for LSP floating windows
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE", fg = colors.blue },

            -- Specifically for nvim-cmp borders
            CmpPmenu = { bg = "NONE" },
            CmpPmenuBorder = { bg = "NONE", fg = colors.blue },
          }
        end,
      })
      -- Activating the theme
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  -- For code comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        -- You can add custom configuration here if needed
      })
    end,
  },
  -- Sessions
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when you open a file
    opts = {
      -- add any options here
    },
    keys = {
      -- Restore last session for current dir
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      -- Restore last session (global)
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      -- Stop persistence (don't save on exit)
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
  -- Dashboard
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        sections = {
          { section = "keys", gap = 1, padding = 1 },
        },
        preset = {
          keys = {
            {
              icon = " ",
              key = "s",
              desc = "Restore Session",
              action = [[:lua require("persistence").load()]],
            },
            { icon = "󰙅 ", key = "e", desc = "Browse Files", action = ":NvimTreeOpen" },
            { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix"
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,      -- Enable debugging if you have issues
      window = {
        layout = "float", -- Since you like floating windows!
        relative = "editor",
        width = 0.8,
        height = 0.8,
        border = "rounded",
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify", -- Optional but recommended for nice popups
    },
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
      -- Whether to add comprehensive default keybindings
      default_mappings = true,
      -- Which builtin marks to show (e.g. '.' for last change, '^' for last insert)
      builtin_marks = { ".", "<", ">", "^" },
      -- Refresh interval in ms
      refresh_interval = 250,
      -- Which sign priority to use
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      -- Disables mark tracking for specific filetypes
      excluded_filetypes = { "NvimTree", "TelescopePrompt" },
    },
  },
}
