local overrides = require "configs.overrides"

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require "configs.lspconfig"
  --   end,
  -- },

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
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.nvim-lint"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- require "plugins.configs.lspconfig"
      require "configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  -- jdtls
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   ft = { "java" },
  --   dependencies = { "williamboman/mason-lspconfig.nvim" },
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
            {
              "tpope/vim-dispatch",
              cmd = { "Make", "Dispatch" },
            },
            {
              "junegunn/fzf",
              build = ":call fzf#install()",
            },
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
    "jvegaf/browse.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    keys = {
      { "<A-s>", "<cmd>VisualSearch<cr>", mode = "v", desc = "Search on web" },
      { "<leader>s", "<cmd>VisualBookmarks<cr>", mode = "v", desc = "Search on web bookmarks" },
      { "<leader>i", "<cmd>InputSearch<cr>", desc = "Search on web bookmarks" },
    },
    config = function()
      -- code
      local bookmarks = {
        ["github"] = {
          ["name"] = "search github from neovim",
          ["code_search"] = "https://github.com/search?q=%s&type=code",
          ["repo_search"] = "https://github.com/search?q=%s&type=repositories",
          ["issues_search"] = "https://github.com/search?q=%s&type=issues",
          ["pulls_search"] = "https://github.com/search?q=%s&type=pullrequests",
        },
        ["npm"] = "https://www.npmjs.com/search?q=%s",
        ["pipy"] = "https://pypi.org/search/?q=%s",
        ["stackoverflow"] = "https://stackoverflow.com/search?q=%s",
        ["youtube"] = "https://www.youtube.com/results?search_query=%s&page=&utm_source=opensearch",
      }

      local browse = require "browse"

      local function command(name, rhs, opts)
        opts = opts or {}
        vim.api.nvim_create_user_command(name, rhs, opts)
      end

      command("InputSearch", function()
        browse.input_search()
      end, {})

      command("VisualSearch", function(input)
        browse.input_search(input)
      end, {})

      -- this will open telescope using dropdown theme with all the available options
      -- in which `browse.nvim` can be used
      command("Browse", function()
        browse.browse { bookmarks = bookmarks }
      end)

      command("Bookmarks", function()
        browse.open_bookmarks { bookmarks = bookmarks }
      end)

      command("VisualBookmarks", function(input)
        browse.open_bookmarks { bookmarks = bookmarks, visual_text = input }
      end)

      command("DevdocsSearch", function()
        browse.devdocs.search()
      end)

      command("DevdocsFiletypeSearch", function()
        browse.devdocs.search_with_filetype()
      end)

      command("MdnSearch", function()
        browse.mdn.search()
      end)
    end,
  },

  {
    "sontungexpt/url-open",
    cmd = "URLOpenUnderCursor",
    config = function()
      local status_ok, url_open = pcall(require, "url-open")
      if not status_ok then
        return
      end
      url_open.setup {}

      vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>")
    end,
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
      {
        "<leader>re",
        "<cmd>lua require('refactoring').refactor('Extract Function')<cr>",
        mode = { "x" },
        desc = "Extract Function",
      },
      {
        "<leader>rf",
        "<cmd>lua require('refactoring').refactor('Extract Function To File')<cr>",
        mode = { "x" },
        desc = "Extract Function to file",
      },
      {
        "<leader>rv",
        "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>",
        mode = { "x" },
        desc = "Extract Variable",
      },
      {
        "<leader>ri",
        "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>",
        mode = { "n", "x" },
        desc = "Inline Variable",
      },
      { "<leader>rb", "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", desc = "Extract Block" },
      {
        "<leader>rbf",
        "<cmd>lua require('refactoring').refactor('Extract Block To File')<cr>",
        desc = "Extract Block to file",
      },
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
    opts = { use_default_keymaps = false },
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
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous { skip_groups = true, jump = true }
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    lazy = false,
    config = function()
      require "configs.nvim-ufo"
    end,
  },
  {
    "junegunn/vim-easy-align",
    event = "User BufReadPre",
    keys = { { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "EasyAlign" } },
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    cmd = "UndotreeToggle",
    keymaps = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree Toggle" },
    },
  },
  {
    "folke/which-key.nvim",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
      local present, wk = pcall(require, "which-key")
      if not present then
        return
      end
      wk.register {
        -- add group
        ["<leader>"] = {
          f = { name = "+Find" },
          l = { name = "+LSP" },
          g = { name = "+Git" },
          c = { name = "+Code" },
          r = { name = "+Refactor" },
          s = { name = "+System" },
          t = { name = "+Test" },
          x = { name = "+Diagnostics" },
          u = { name = "+UI" },
        },
      }
      wk.register {
        -- add group
        ["<leader>c"] = {
          r = { name = "+Run" },
        },
      }
      wk.register {
        -- add group
        ["<leader>g"] = {
          d = { name = "+Diff" },
          h = { name = "+Hunk" },
        },
      }
    end,
    setup = function()
      require("core.utils").load_mappings "whichkey"
    end,
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    event = "InsertEnter",
    opts = overrides.copilot,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        enabled = false,
        config = function()
          require("copilot_cmp").setup()
        end,
      },
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
      -- stylua: ignore
      { "<leader>dPt", function() require("dap-python").test_method() end, desc = "Debug Method", ft = "python" },
      {
        "<leader>dPc",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug Class",
        ft = "python",
      },
    },
    config = function()
      require "configs.dap"
    end,
  },
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
    -- stylua: ignore
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run File" },
      {
        "<leader>tT",
        function()
          require("neotest").run.run(vim.loop.cwd())
        end,
        desc = "Run All Test Files",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open { enter = true, auto_close = true }
        end,
        desc = "Show Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop",
      },
      {
        "<leader>td",
        function()
          require("neotest").run.run { strategy = "dap" }
        end,
        desc = "Debug Nearest",
      },
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
  { "CRAG666/code_runner.nvim", event = "VeryLazy", config = true },
  { "kdheepak/lazygit.nvim", event = "VeryLazy", cmd = "LazyGit" },
  { "mvllow/modes.nvim", event = "VeryLazy", opts = overrides.modes },
}


