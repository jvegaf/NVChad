local M = {}
local cmp = require "cmp"

M.treesitter = {
  ensure_installed = {
    "javascript",
    "json",
    "jsonc",
    "lua",
    "markdown",
    "python",
    "toml",
    "yaml",
    "tsx",
    "typescript",
    "vim",
    "xml",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "eslint-lsp",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    --java
    "jdtls",
    "lemminx",

    --python
    "pyright",
    "ruff-lsp",
    "ruff",

    "stylelint-lsp",
    "jsonlint",
    "json-lsp",
    "hadolint",
    "shellcheck",

    "js-debug-adapter",
    "java-debug-adapter",
    "java-test",
    "checkstyle",

    "codelldb",
    "rust-analyzer",
  },
}

local api = require "nvim-tree.api"
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)

local function my_on_attach(bufnr)
  local function edit_or_open()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
      -- expand or collapse folder
      api.node.open.edit()
    else
      -- open file
      api.node.open.edit()
      -- Close the tree if file was opened
      api.tree.close()
    end
  end

  -- open as vsplit on current node
  local function vsplit_preview()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
      -- expand or collapse folder
      api.node.open.edit()
    else
      -- open file as vsplit
      api.node.open.vertical()
    end

    -- Finally refocus on tree if it was lost
    api.tree.focus()
  end

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "l", edit_or_open, opts "Edit Or Open")
  vim.keymap.set("n", "L", vsplit_preview, opts "Vsplit Preview")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Folder")
  vim.keymap.set("n", "H", api.node.navigate.parent, opts "Parent")
end

-- git support in nvimtree
M.nvimtree = {
  hijack_cursor = true,
  filters = {
    git_ignored = false,
    exclude = {},
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  diagnostics = {
    enable = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
      resize_window = false,
    },
  },
  view = {
    width = 40,
    relativenumber = true,
  },
  git = {
    enable = true,
    timeout = 500,
  },
  on_attach = my_on_attach,
  renderer = {
    highlight_git = true,
    root_folder_label = true,
    icons = {
      show = {
        git = true,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
}

M.copilot = {
  -- Possible configurable fields can be found on:
  -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
  md = "Copilot",
  event = "InsertEnter",
  suggestion = {
    enable = false,
  },
  panel = {
    enable = false,
  },
}

local cmp_active = false
M.cmp = {
  sources = {
    { name = "nvim_lsp", group_index = 2 },
    { name = "copilot", group_index = 2 },
    { name = "luasnip", group_index = 2 },
    { name = "crates", group_index = 2 },
    { name = "buffer", group_index = 2 },
    { name = "nvim_lua", group_index = 2 },
    { name = "emoji", group_index = 2 },
    { name = "path", group_index = 2 },
  },

  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 0 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 0 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ["<C-Right>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 0 and cmp_active then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<C-Enter>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },

  event = {
    on_confirm_done = function()
      cmp_active = false
    end,
    on_menu_open = function()
      cmp_active = true
    end,
    on_menu_close = function()
      cmp_active = false
    end,
  },
}

M.modes = {
  colors = {
    copy = "#f5c359",
    delete = "#c75c6a",
    insert = "#78ccc5",
    visual = "#9745be",
  },

  -- Set opacity for cursorline and number background
  line_opacity = 0.15,

  -- Enable cursor highlights
  set_cursor = true,

  -- Enable cursorline initially, and disable cursorline for inactive windows
  -- or ignored filetypes
  set_cursorline = true,

  -- Enable line number highlights to match cursorline
  set_number = true,

  -- Disable modes highlights in specified filetypes
  -- Please PR commonly ignored filetypes
  ignore_filetypes = { "NvimTree", "TelescopePrompt" },
}

return M
