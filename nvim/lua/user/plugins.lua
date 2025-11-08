local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'morhetz/gruvbox',
    priority=1000,
    config=function()
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
  "nvim-lua/popup.nvim",
  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
    }
  },

  -- snippets
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",

  -- LSP
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  -- Fast TypeScript LSP (better than ts_ls)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "nvim-telescope/telescope-media-files.nvim",
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  -- Autopair
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  -- Todo comment
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  -- Trouble
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "nvzone/typr",
    cmd="TyprStats",
    dependencies="nvzone/volt",
    opts={},
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && pnpm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_browser = "safari"
      vim.g.mkdp_debug = 1
    end
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    priority = 1000, -- Load early to avoid treesitter conflicts
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("markview").setup({
        experimental = {
          check_rtp = false -- Disable runtime path checking
        },
        preview = {
          modes = { "n", "no", "c" }, -- Change these modes to what you need
          hybrid_modes = { "n" },     -- Uses this feature on normal mode
          callbacks = {
            on_enable = function (_, win)
              vim.wo[win].conceallevel = 2;
              vim.wo[win].concealcursor = "c";
            end
          }
        }
      })
    end
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      -- Your toggleterm config (optional)
      direction = "float",  -- or "horizontal"/"vertical"
      shell = "zsh",        -- Default shell
    },
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "th", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "tH", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  }
  --  {
  --    "yetone/avante.nvim",
  --    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --    -- ⚠️ must add this setting! ! !
  --    build = function()
  --      -- conditionally use the correct build system for the current OS
  --      if vim.fn.has("win32") == 1 then
  --        return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --      else
  --        return "make"
  --      end
  --    end,
  --    event = "VeryLazy",
  --    version = false, -- Never set this value to "*"! Never!
  --    ---@module 'avante'
  --    ---@type avante.Config
  --    opts = {
  --      -- add any opts here
  --      -- for example
  --      provider = "claude",
  --      providers = {
  --        claude = {
  --          endpoint = "https://api.anthropic.com",
  --          model = "claude-sonnet-4-20250514",
  --          timeout = 30000, -- Timeout in milliseconds
  --          extra_request_body = {
  --            temperature = 0.75,
  --            max_tokens = 20480,
  --          },
  --        },
  --      },
  --    },
  --    dependencies = {
  --      "nvim-lua/plenary.nvim",
  --      "MunifTanjim/nui.nvim",
  --      --- The below dependencies are optional,
  --      "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --      "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --      "stevearc/dressing.nvim", -- for input provider dressing
  --      "folke/snacks.nvim", -- for input provider snacks
  --      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --      "zbirenbaum/copilot.lua", -- for providers='copilot'
  --      {
  --        -- support for image pasting
  --        "HakonHarnes/img-clip.nvim",
  --        event = "VeryLazy",
  --        opts = {
  --          -- recommended settings
  --          default = {
  --            embed_image_as_base64 = false,
  --            prompt_for_file_name = false,
  --            drag_and_drop = {
  --              insert_mode = true,
  --            },
  --            -- required for Windows users
  --            use_absolute_path = true,
  --          },
  --        },
  --      },
  --      {
  --        -- Make sure to set this up properly if you have lazy=true
  --        'MeanderingProgrammer/render-markdown.nvim',
  --        opts = {
  --          file_types = { "markdown", "Avante" },
  --        },
  --        ft = { "markdown", "Avante" },
  --      },
  --    },
  --  }
})

