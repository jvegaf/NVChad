local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    -- Go: imports + formatting + line length
    -- go = { "goimports-reviser", "gofmt", "golines" },
    -- Rust
    -- rust = { "rustfmt" },
    -- YAML/JSON
    yaml = { "yamlfmt" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    -- Web development
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    -- vue = { "prettierd" },
    -- svelte = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    html = { "prettierd" },
    markdown = { "prettierd" },
    -- graphql = { "prettierd" },
    -- Terraform
    -- terraform = { "terraform_fmt" },
    -- tf = { "terraform_fmt" },
    -- ["terraform-vars"] = { "terraform_fmt" },
    -- Shell
    sh = { "shfmt" },
    bash = { "shfmt" },
    -- SQL
    -- sql = { "sqlfluff" },
  },

  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
