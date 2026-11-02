-- Load NvChad's LSP theme and diagnostic config
dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

-- Setup keymaps on LspAttach (from NvChad but without disabling semantic tokens)

-- Basic servers
local servers = {
  "html",
  "cssls",
  "ts_ls",
  "clangd",
  -- "rust_analyzer",
  "pyright",
  "yamlls",
  "jsonls",
  "dockerls",
  "vimls",
  -- Web development
  "tailwindcss", -- Tailwind CSS
  "eslint", -- ESLint
  -- "emmet_ls",        -- Emmet (HTML/CSS snippets)
  -- Kubernetes
  -- "helm_ls",         -- Helm charts
}

vim.lsp.enable(servers)

-- YAML with Kubernetes schema validation
vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = {
        kubernetes = "*.yaml",
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        ["http://json.schemastore.org/taskfile"] = "Taskfile*.{yml,yaml}",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
        ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
      },
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      validate = true,
      completion = true,
      hover = true,
    },
  },
})
