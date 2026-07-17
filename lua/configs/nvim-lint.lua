require('lint').linters_by_ft = {
  typescript = {'eslint'},
  typescriptreact = {'eslint'},
  javascript = {'eslint'},
  javascriptreact = {'eslint'},
  -- lua = {'luacheck'},
  sh = {'shellcheck'},
  yaml = {'yamllint'},
  json = {'jsonlint'},
  -- html = {'tidy'},
  css = {'stylelint'},
  scss = {'stylelint'},
  sass = {'stylelint'},
  less = {'stylelint'},
  vue = {'eslint'},
  java = {'checkstyle'},
  python = {'ruff'},
  -- kotlin = {'ktlint'},
  c = {'clangd'},
  cpp = {'clangd'},
  dockerfile = {'hadolint'},
}

vim.api.nvim_create_autocmd({ 'BufWritePost'}, {
  callback = function()
    require('lint').try_lint()
  end,
})
