return {
  {
    'dinhhuy258/git.nvim',
    event = 'BufReadPre',
    opts = {
      keymaps = {
        -- Open blame window
        blame = '<Leader>gB',
        -- Open file/folder in git repository
        browse = '<Leader>go',
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    enabled = true,
    event = 'BufReadPre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<localleader>gs', '<cmd>Gitsigns stage_buffer<cr>', desc = 'Stage buffer' },
      { '<localleader>gu', '<cmd>Gitsigns undo_stage_buffer<cr>', desc = 'Undo stage buffer' },
      { '<localleader>gr', '<cmd>Gitsigns reset_buffer<cr>', desc = 'Reset buffer' },
      { '<localleader>gp', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Preview hunk' },
      { '<localleader>gb', '<cmd>Gitsigns blame_line<cr>', desc = 'Blame line' },
      { '<localleader>gn', '<cmd>Gitsigns next_hunk<cr>', desc = 'Next hunk' },
      { '<localleader>gp', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Prev hunk' },
      { '<localleader>gr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset hunk' },
      { '<localleader>gs', '<cmd>Gitsigns stage_hunk<cr>', desc = 'Stage hunk' },
      { '<localleader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = 'Undo stage hunk' },
      { '<localleader>gv', '<cmd>Gitsigns select_hunk<cr>', desc = 'Select hunk' },
      { '<localleader>gl', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = 'Toggle current line blame' },
      { '<localleader>gs', '<cmd>Gitsigns toggle_signs<cr>', desc = 'Toggle signs' },
      { '<localleader>gp', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Preview hunk' },
      { '<localleader>gr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset hunk' },
      { '<localleader>gs', '<cmd>Gitsigns stage_hunk<cr>', desc = 'Stage hunk' },
      { '<localleader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = 'Undo stage hunk' },
      { '<localleader>gv', '<cmd>Gitsigns select_hunk<cr>', desc = 'Select hunk' },
      { '<localleader>gl', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = 'Toggle current line blame' },
    },
  },
  {
    'sindrets/diffview.nvim',
    enabled = false,
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open diff' },
      { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = 'Close diff' },
      { '<leader>gf', '<cmd>DiffviewFileHistory %<cr>', desc = 'View file history' },
      { '<leader>gf', ":'<,'>DiffviewFileHistory<cr>", mode = { 'v' }, desc = 'View selected history' },
    },
  },
  {
    'esmuellert/codediff.nvim',
    cmd = 'CodeDiff',
    keys = {
      { '<leader>gd', '<cmd>CodeDiff HEAD<cr>', desc = 'Open diff from last commit' },
      { '<leader>gf', '<cmd>CodeDiff history<cr>', desc = 'View file history' },
      { '<leader>gf', ":'<,'>CodeDiff history<cr>", mode = { 'v' }, desc = 'View selected history' },
    },
  },
  {
    'wintermute-cell/gitignore.nvim',
    config = function()
      require('gitignore')
    end,
  },
  {
    'folke/snacks.nvim',
    keys = {
      {
        '<leader>gz',
        function()
          Snacks.picker.git_log()
        end,
        desc = 'Commits (diff preview)',
      },
      {
        '<leader>gb',
        function()
          Snacks.picker.git_branches()
        end,
        desc = 'Branches',
      },
    },
  },
}
