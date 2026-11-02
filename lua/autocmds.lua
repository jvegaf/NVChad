require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- autocmd("BufReadPost", {
--   pattern = "*",
--   callback = function()
--     local line = vim.fn.line "'\""
--     if
--       line > 1
--       and line <= vim.fn.line "$"
--       and vim.bo.filetype ~= "commit"
--       and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
--     then
--       vim.cmd 'normal! g`"'
--     end
--   end,
-- })

-- autocmd("BufDelete", {
--   callback = function()
--     local bufs = vim.t.bufs
--     if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
--       vim.cmd "Nvdash"
--     end
--   end,
-- })

autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local function opts(desc)
      return { buffer = bufnr, desc = "LSP " .. desc }
    end

    local map = vim.keymap.set
    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "gr", vim.lsp.buf.references, opts "Show references")
    map("n", "K", vim.lsp.buf.hover, opts "Hover documentation")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")
    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
    map("n", "<leader>ra", vim.lsp.buf.rename, opts "Rename")
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("i", "<C-k>", vim.lsp.buf.signature_help, opts "Signature help")

    -- Enable semantic tokens if supported (NOT disabled like NvChad default)
    if client and client.server_capabilities.semanticTokensProvider then
      vim.lsp.semantic_tokens.start(bufnr, args.data.client_id)
    end
  end,
})
