return {
  "askfiy/lsp_extra_dim",
  event = { "LspAttach" },
  config = function()
    require("lsp_extra_dim").setup()
  end,
}
