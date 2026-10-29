-- stylua: ignore
local overrides = require "configs.overrides"

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  -- {
  --   "mfussenegger/nvim-lint",
  --   event = "VeryLazy",
  --   config = function()
  --     require "configs.nvim-lint"
  --   end,
  -- },
  -- jdtls
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   ft = { "java" },
  --   deendencies = {
  --     "neovim/nvim-lspconfig",
  --     opts = {
  --       setup = {
  --         -- disable jdtls config from lspconfig
  --         jdtls = function()
  --           return true
  --         end,
  --       },
  --     },
  --   },
  --   config = function()
  --     require "configs.jdtls"
  --   end,
  -- },
  -- {
  --   "simaxme/java.nvim",
  --   ft = { "java" },
  -- },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  --
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-lua/popup.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        dependencies = {
          "junegunn/fzf.vim",
          dependencies = {
            { "tpope/vim-dispatch", cmd = { "Make", "Dispatch" } },
            { "junegunn/fzf", build = ":call fzf#install()" },
          },
        },
      },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      "benfowler/telescope-luasnip.nvim",
      "debugloop/telescope-undo.nvim",
      {
        "paopaol/telescope-git-diffs.nvim",
        dependencies = { "sindrets/diffview.nvim" },
      },
    },
    config = function()
      require("telescope").load_extension "undo"
      require("telescope").load_extension "git_diffs"
      require("telescope").load_extension "file_browser"
      require("telescope").load_extension "ui-select"
      require("telescope").load_extension "fzf"
    end,
  },
  {
    "LunarVim/bigfile.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufWinEnter",
    opts = {
      lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
      lastplace_ignore_filetype = { "gitcommit", "gitrebase", "hgcommit" },
      lastplace_open_folds = true,
    },
  },
  {
    "lalitmee/browse.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    keys = {
      { '<leader>ff', '<cmd>VisualSearch<cr>', mode = 'v', desc = 'Search on web' },
      { '<leader>fb', '<cmd>VisualBookmarks<cr>', mode = 'v', desc = 'Search on web bookmarks' },
      { '<leader>si', '<cmd>InputSearch<cr>', desc = 'Search on web' },
    },
    config = function()
      require("configs.browse")
    end,
  },

  {
    'sontungexpt/url-open',
    event = 'VeryLazy',
    cmd = 'URLOpenUnderCursor',
    config = function()
      local status_ok, url_open = pcall(require, 'url-open')
      if not status_ok then
        return
      end
      url_open.setup({})

      vim.keymap.set('n', 'gx', '<esc>:URLOpenUnderCursor<cr>')
    end,
  },
  -- urlview
  {
    'axieax/urlview.nvim',
    cmd = { 'UrlView' },
    keys = {
      { '<leader>bu', '<cmd>UrlView buffer<cr>', desc = 'urlview: buffers' },
      { '<leader>zu', '<cmd>UrlView lazy<cr>', desc = 'urlview: lazy' },
      { '<leader>bU', '<cmd>UrlView buffer action=clipboard<cr>', desc = 'urlview: copy links' },
    },
    opts = {
      default_title = 'Links:',
      default_picker = 'native',
      default_prefix = 'https://',
      default_action = 'system',
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>rr", "<cmd>lua require('refactoring').select_refactor()<cr>", mode = { "n", "x" }, desc = "Refactor" },
      { "<leader>re", "<cmd>lua require('refactoring').refactor('Extract Function')<cr>", mode = { "x" }, desc = "Extract Function" },
      { "<leader>rf", "<cmd>lua require('refactoring').refactor('Extract Function To File')<cr>", mode = { "x" }, desc = "Extract Function to file" },
      { "<leader>rv", "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>", mode = { "x" }, desc = "Extract Variable" },
      { "<leader>ri", "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>", mode = { "n", "x" }, desc = "Inline Variable" },
      { "<leader>rb", "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", desc = "Extract Block" },
      { "<leader>rbf", "<cmd>lua require('refactoring').refactor('Extract Block To File')<cr>", desc = "Extract Block to file" },
    },
    config = function()
      require("refactoring").setup {}
      require("telescope").load_extension "refactoring"
    end,
  },
  {
    "Wansmer/treesj",
    keys = { { "<leader>m", "<CMD>TSJToggle<CR>", desc = "Toggle Split Join" } },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = {
      use_default_keymaps = false,
      max_join_length = 200,
    },
  },
  {
    "mg979/vim-visual-multi",
    keys = {
      "<C-n>",
      "<C-Up>",
      "<C-Down>",
      "<S-Up>",
      "<S-Down>",
      "<S-Left>",
      "<S-Right>",
    },
    config = function()
      vim.g.VM_leader = ";"
    end,
  },

  -- trouble
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xs", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      { "[q", function() if require("trouble").is_open() then require("trouble").previous { skip_groups = true, jump = true } else vim.cmd.cprev() end end, desc = "Previous trouble/quickfix item" },
      { "]q", function() if require("trouble").is_open() then require("trouble").next { skip_groups = true, jump = true } else vim.cmd.cnext() end end, desc = "Next trouble/quickfix item" },
    },
  },

  -- ufo
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    lazy = false,
    config = function()
      require "configs.nvim-ufo"
    end,
  },
  -- EasyAlign
  {
    "junegunn/vim-easy-align",
    event = "User BufReadPre",
    keys = { { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "EasyAlign" } },
  },
  -- undotree
  {
    "mbbill/undotree",
    event = "VeryLazy",
    cmd = "UndotreeToggle",
    keymaps = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree Toggle" },
    },
  },
  -- {
  --   "folke/which-key.nvim",
  --   config = function(_, opts)
  --     dofile(vim.g.base46_cache .. "whichkey")
  --     require("which-key").setup(opts)
  --     local present, wk = pcall(require, "which-key")
  --     if not present then
  --       return
  --     end
  --     wk.register {
  --       -- add group
  --       ["<leader>"] = {
  --         f = { name = "+Find" },
  --         l = { name = "+LSP" },
  --         g = { name = "+Git" },
  --         c = { name = "+Code" },
  --         r = { name = "+Refactor" },
  --         s = { name = "+System" },
  --         t = { name = "+Test" },
  --         x = { name = "+Diagnostics" },
  --         u = { name = "+UI" },
  --       },
  --     }
  --     wk.register {
  --       -- add group
  --       ["<leader>c"] = {
  --         r = { name = "+Run" },
  --       },
  --     }
  --     wk.register {
  --       -- add group
  --       ["<leader>g"] = {
  --         d = { name = "+Diff" },
  --         h = { name = "+Hunk" },
  --       },
  --     }
  --   end,
  --   setup = function()
  --     require("core.utils").load_mappings "whichkey"
  --   end,
  -- },
  -- splits
{
  'smart-splits-nvim/smart-splits.nvim',
  version = '^3.0.0',
  dependencies = {
    { 'smart-splits-nvim/backend-tmux', main = 'smart-splits-backend-tmux' },
    { 'smart-splits-nvim/backend-zellij-lua', main = 'smart-splits-backend-zellij-lua' },
    {
      'adriankarlen/smart-splits-backend-herdr',
      main = 'smart-splits-backend-herdr',
      opts = {}, -- see Options
    },
  },
  opts = {
    mux = { backend = { 'smart-splits-backend-tmux', 'smart-splits-backend-herdr', 'smart-splits-backend-zellij-lua' } },
    -- Match tmux's @smart-splits_at_edge 'wrap' setting
    move = { at_edge = 'wrap' },
    resize = { at_edge = 'wrap' },
  },
  keys = {
    -- Resize splits
    { '<C-Left>', function() require('smart-splits').resize_left() end, desc = 'Resize left' },
    { '<C-Down>', function() require('smart-splits').resize_down() end, desc = 'Resize down' },
    { '<C-Up>', function() require('smart-splits').resize_up() end, desc = 'Resize up' },
    { '<C-Right>', function() require('smart-splits').resize_right() end, desc = 'Resize right' },
    -- Move between splits
    { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = 'Move left' },
    { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = 'Move down' },
    { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = 'Move up' },
    { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = 'Move right' },
    -- Swap buffers
    { '<leader><leader>h', function() require('smart-splits').swap_buf_left() end, desc = 'Swap left' },
    { '<leader><leader>j', function() require('smart-splits').swap_buf_down() end, desc = 'Swap down' },
    { '<leader><leader>k', function() require('smart-splits').swap_buf_up() end, desc = 'Swap up' },
    { '<leader><leader>l', function() require('smart-splits').swap_buf_right() end, desc = 'Swap right' },
  },
},

  -- copilot
  -- {
  --   "zbirenbaum/copilot.lua",
  --   enabled = false,
  --   event = "InsertEnter",
  --   opts = overrides.copilot,
  -- },
  -- cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- {
      --   "zbirenbaum/copilot-cmp",
      --   enabled = false,
      --   config = function()
      --     require("copilot_cmp").setup()
      --   end,
      -- },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-git",
    },
    opts = overrides.cmp,
  },

  -- dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "anuvyklack/hydra.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "rcarriga/cmp-dap",
    },
    keys = {
      { "<leader>dd", desc = "Open Debug menu" },
      { "<leader>dPt", function() require("dap-python").test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require("dap-python").test_class() end, desc = "Debug Class", ft = "python" },
    },
    config = function()
      require "configs.dap"
    end,
  },
  
  -- test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "mfussenegger/nvim-dap",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
      },
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open { enter = true, auto_close = true } end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>td", function() require("neotest").run.run { strategy = "dap" } end, desc = "Debug Nearest" },
    },
  },

  -- Git
  { "lewis6991/gitsigns.nvim", event = "BufReadPre", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    config = true,
  },
  { "kdheepak/lazygit.nvim", event = "VeryLazy", cmd = "LazyGit" },
  { "mvllow/modes.nvim", event = "VeryLazy", opts = overrides.modes },
}
