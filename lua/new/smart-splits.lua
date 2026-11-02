-- stylua: ignore
-- Install smart-splits.nvim and a backend
return {
  'smart-splits-nvim/smart-splits.nvim',
  version = '^3.0.0',
  dependencies = {
    { 'smart-splits-nvim/backend-tmux', main = 'smart-splits-backend-tmux' },
    { 'smart-splits-nvim/backend-zellij-lua', main = 'smart-splits-backend-zellij-lua' },
    {
      'adriankarlen/smart-splits-backend-herdr',
      main = 'smart-splits-backend-herdr',
      opts = {}, -- see Options
    },
  },
  opts = {
    mux = { backend = { 'smart-splits-backend-tmux', 'smart-splits-backend-herdr', 'smart-splits-backend-zellij-lua' } },
    -- Match tmux's @smart-splits_at_edge 'wrap' setting
    move = { at_edge = 'wrap' },
    resize = { at_edge = 'wrap' },
  },
  keys = {
    -- Resize splits
    { '<C-Left>', function() require('smart-splits').resize_left() end, desc = 'Resize left' },
    { '<C-Down>', function() require('smart-splits').resize_down() end, desc = 'Resize down' },
    { '<C-Up>', function() require('smart-splits').resize_up() end, desc = 'Resize up' },
    { '<C-Right>', function() require('smart-splits').resize_right() end, desc = 'Resize right' },
    -- Move between splits
    { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = 'Move left' },
    { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = 'Move down' },
    { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = 'Move up' },
    { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = 'Move right' },
    -- Swap buffers
    { '<localleader>h', function() require('smart-splits').swap_buf_left() end, desc = 'Swap left' },
    { '<localleader>j', function() require('smart-splits').swap_buf_down() end, desc = 'Swap down' },
    { '<localleader>k', function() require('smart-splits').swap_buf_up() end, desc = 'Swap up' },
    { '<localleader>l', function() require('smart-splits').swap_buf_right() end, desc = 'Swap right' },
  },
}
