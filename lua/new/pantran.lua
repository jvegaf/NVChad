return {
  'potamides/pantran.nvim',
  event = 'VeryLazy',
  cmd = { 'Pantran' },
  config = function()
    local pantran = require('pantran')
    local opts = { noremap = true, silent = true, expr = true }
    vim.keymap.set('n', '<leader>tr', pantran.motion_translate, opts)
    vim.keymap.set('n', '<leader>trr', function()
      return pantran.motion_translate() .. '_'
    end, opts)
    vim.keymap.set('x', '<leader>tr', pantran.motion_translate, opts)

    pantran.setup({
      default_engine = 'google',
      default_target = 'en',
    })
  end,
}
