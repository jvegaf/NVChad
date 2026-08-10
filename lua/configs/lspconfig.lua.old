-- local on_attach = require("plugins.configs.lspconfig").on_attach
-- local capabilities = require("plugins.configs.lspconfig").capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

---@diagnostic disable-next-line: different-requires
local lspconfig = vim.lsp.config()

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "clangd",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      -- importModuleSpecifierPreference = "relative",
      disableSuggestions = true,
    },
  },
}

lspconfig.eslint.setup {
  settings = {
    codeAction = {
      disableRuleComment = { enable = true },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticSeverityOverrides = {
          reportMissingImports = "information",
        },
      },
    },
  },
}


lspconfig.ruff_lsp.keys = {
  {
    "<leader>co",
    function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.organizeImports" },
          diagnostics = {},
        },
      })
    end,
    desc = "Organize Imports",
  },
}

lspconfig.ruff_lsp.setup {
  capabilities = capabilities,
  on_attach = function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end,
}
