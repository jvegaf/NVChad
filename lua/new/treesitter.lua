return {
  { 'fei6409/log-highlight.nvim', event = 'BufRead *.log', opts = {} },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        'tsx',
        'typescript',
        'java',
        'xml',
        'yaml',
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'LazyFile',
    opts = function()
      local tsc = require('treesitter-context')
      Snacks.toggle({
        name = 'Treesitter Context',
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map('<leader>ut')
      return { mode = 'cursor', max_lines = 3 }
    end,
  },
}
