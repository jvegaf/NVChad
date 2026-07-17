--stylua: ignore start

local status, builtin = pcall(require, "telescope.builtin")
if not status then
  return
end
require "nvchad.mappings"

-- add yours here

local NS = { noremap = true, silent = true }
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
--
--
--


-- General keymaps
map("i", "jk", "<ESC>", NS)           -- exit insert mode with jk
map("n", "vv", "V", NS)
map("n", "<leader>q", ":q!<CR>", NS)  -- quit without saving
-- map("n", "<localleader>w", ":w<CR>", NS)           -- save
-- map("n", "<localleader>q", ":Bdelete<CR>", NS)     -- close buffer
map("n", "W", ":w<CR>", NS)           -- save
map("v", "y", "myy`y", NS)     -- close buffer

  map("n", "q", function()
    require("nvchad.tabufline").close_buffer()
  end, { desc = "buffer close" })

-- Buffers
map("n", "H", ":BufferLineCyclePrev<cr>", NS)
map("n", "L", ":BufferLineCycleNext<cr>", NS)
map("n", "<leader>bb", ":e #<cr>", NS)
map("n", "<localleader><Space>", ":Telescope buffers<cr>", NS)


-- Split window management
-- map("n", "<leader>sv", "<C-w>v") -- split window vertically
-- map("n", "<leader>sh", "<C-w>s") -- split window horizontally
-- map("n", "<leader>se", "<C-w>=") -- make split windows equal width
-- map("n", "<leader>sx", ":close<CR>") -- close split window
-- map("n", "<leader>sj", "<C-w>-") -- make split window height shorter
-- map("n", "<leader>sk", "<C-w>+") -- make split windows height taller
-- map("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger
-- map("n", "<leader>sh", "<C-w><5") -- make split windows width smaller

-- Tab management
map("n", "<localleader>to", ":tabnew<CR>")   -- open a new tab
map("n", "<localleader>tx", ":tabclose<CR>") -- close a tab
map("n", "<localleader>tn", ":tabn<CR>")     -- next tab
map("n", "<localleader>tp", ":tabp<CR>")     -- previous tab
map("n", "<localleader>,", ":tabNext<CR>")

-- Diff keymaps
-- map("n", "<leader>cc", ":diffput<CR>") -- put diff from current to other during diff
-- map("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
-- map("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
-- map("n", "<leader>cn", "]c") -- next diff hunk
-- map("n", "<leader>cp", "[c") -- previous diff hunk

-- Quickfix keymaps
map("n", "<localleader>qo", ":copen<CR>")  -- open quickfix list
map("n", "<localleader>qf", ":cfirst<CR>") -- jump to first quickfix list item
map("n", "<localleader>qn", ":cnext<CR>")  -- jump to next quickfix list item
map("n", "<localleader>qp", ":cprev<CR>")  -- jump to prev quickfix list item
map("n", "<localleader>ql", ":clast<CR>")  -- jump to last quickfix list item
map("n", "<localleader>qc", ":cclose<CR>") -- close quickfix list

-- Vim-maximizer
-- map("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle maximize tab

-- FileBrowser
map("n", "<leader>e", ":NvimTreeFocus<CR>", NS)          -- toggle file explorer
map("n", "<leader>E", ":Telescope file_browser<CR>", NS) -- toggle focus to file explorer

-- Telescope
map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>fc", builtin.git_commits, { desc = "Git Commit" })
map("n", "<leader>fe", builtin.git_files, { desc = "Git files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Find keymap" })
map("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Search in buffer" })
map("n", "<leader>fo", builtin.lsp_document_symbols, { desc = "Document symbols" })
map("n", "<leader>fi", builtin.lsp_incoming_calls, { desc = "Incoming calls" })
map("n", "<leader>fm", function() builtin.treesitter({ default_text = ":method:" }) end, { desc = "Find methods" })

-- Git-blame
-- map("n", "<leader>gb", ":GitBlameToggle<CR>") -- toggle git blame

-- Harpoon
-- map("n", "<leader>ha", require("harpoon.mark").add_file)
-- map("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu)
-- map("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end)
-- map("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end)
-- map("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end)
-- map("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end)
-- map("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end)
-- map("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end)
-- map("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end)
-- map("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end)
-- map("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end)

-- LSP
map("n", "<leader>li", ":LspInfo<cr>", { desc = "LSP Info" })
map("n", "<leader>lr", ":LspReset<cr>", { desc = "LSP Reset" })
-- map("n", "K", function() vim.lsp.buf.hover() end, NS)
-- map({ "v", "n" }, "<leader>xc", require("actions-preview").code_actions, { desc = "Code Actions" })
-- map("n", "gd", function() builtin.lsp_definitions({ reuse_win = true }) end, { desc = "definition" })
-- map("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Goto Declaration" })
-- map("n", "gI", function() builtin.lsp_implementations({ reuse_win = true }) end, { desc = "Goto implementation" })
-- map("n", "gy", function() builtin.lsp_type_definitions({ reuse_win = true }) end,
--   { desc = "Goto type_definition" })
-- map("n", "<leader>xx", function() builtin.diagnostics({ bufnr = 0 }) end, { desc = "Buffer diagnostics" })
-- map("n", "<leader>xX", function() builtin.diagnostics({ root_dir = true }) end, { desc = "cwd diagnostics" })
-- map("n", "gr", function() builtin.lsp_references({ reuse_win = true }) end, { desc = "References" })
-- map("n", "gK", function() vim.lsp.buf.signature_help() end, { desc = "Signature help" })
-- map("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "Rename Buffer" })
-- map('n', 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "format buffer"})
-- map({ 'n', 'v' }, 'gq', function() require("conform").format({ async = true, lsp_format = "fallback" }) end, { desc = "Format"})
-- map('n', '<leader>xc', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "Code Action"})
-- map('n', '<leader>xx', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Open Float"})
-- map("n", "gk", function() vim.diagnostic.goto_prev() end, { desc = "Previous Diagnostic" })
-- map("n", "gj", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
-- map("n", "gS", function() vim.lsp.buf.document_symbol() end, { desc = "Document Symbol" })
-- map("i", "<C-Space>", function() vim.lsp.buf.completion({ bufnr = 0 }) end, { desc = "References" })

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)

-- Debugging
map("n", "<leader>d?", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end)
map("n", "<leader>dC", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
map("n", "<leader>dL", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
map("n", "<leader>dR", "<cmd>lua require'dap'.clear_breakpoints()<cr>")
map("n", "<leader>da", "<cmd>Telescope dap list_breakpoints<cr>")
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
map("n", "<leader>dd", function()
  require("dap").disconnect()
  require("dapui").close()
end)
map("n", "<leader>de", function() builtin.diagnostics({ default_text = ":E:" }) end)
map("n", "<leader>df", "<cmd>Telescope dap frames<cr>")
map("n", "<leader>dh", "<cmd>Telescope dap commands<cr>")
map("n", "<leader>di", function()
  require("dap.ui.widgets").hover()
end)
map("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
map("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
map("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
map("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
map("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
map("n", "<leader>dt", function()
  require("dap").terminate()
  require("dapui").close()
end)

-- dont yank on visual paste
map("v", "p", '"_dP', NS)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", NS)

-- Select all
map("n", "<C-a>", "gg<S-v>G", NS)

map("v", "<", "<gv", { desc = "Stay in indent mode" })
map("v", ">", ">gv", { desc = "Stay in indent mode" })

-- Move Lines
map("n", "<M-j>", ":m .+1<cr>==", { desc = "Move down" })
map("n", "<M-k>", ":m .-2<cr>==", { desc = "Move up" })
map("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Jumplist
map("n", "<C-m>", "<C-i>", NS)

-- Treesj
map("n", "<leader>j", function()
  require('treesj').toggle({ split = { recusive = true } })
end, { noremap = true, silent = true, desc = "Toggle Split Join" })

-- System
map("n", "<leader>zc", ":e $MYVIMRC<cr>", { noremap = true, silent = true, desc = "Config" })
map("n", "<leader>zn", ":Telescope notify<cr>", { noremap = true, silent = true, desc = "Notifications" })
map("n", "<leader>zh", ":checkhealth<cr>", { noremap = true, silent = true, desc = "Health" })
map("n", "<leader>zm", ":Mason<cr>", { noremap = true, silent = true, desc = "Mason" })
map("n", "<leader>zl", ":Lazy<cr>", { noremap = true, silent = true, desc = "Lazy" })
map("n", "<leader>za", ":messages<cr>", { desc = "Messages" })

-- UI
map("n", "<leader>ui", ':exec &bg=="light"? "set bg=dark" : "set bg=light"<cr>',
  { noremap = true, silent = true, desc = "Toggle Background" })
map("n", "<leader>uc", function() builtin.colorscheme({ enable_preview = true }) end, { desc = "Colorschemes" })
map("n", "<leader>ut", function() require('onedark').load() end, { desc = "transparent" })

--stylua: ignore end
