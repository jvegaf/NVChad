return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'MahanRahmati/blink-nerdfont.nvim',
      {
        'mikavilpas/blink-ripgrep.nvim',
        version = '*', -- use the latest stable version
      },
      'alexandre-abrioux/blink-cmp-npm.nvim',
    },
    opts = {
      fuzzy = { implementation = 'rust' },
      cmdline = {
        completion = {
          list = { selection = { preselect = false } },
          menu = { auto_show = true },
        },
      },
      completion = {
        menu = {
          border = 'rounded',
          direction_priority = { 'n', 's' },
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind' },
            },
          },
        },
      },
      sources = {
        default = {
          'lazydev',
          'lsp',
          'path',
          'snippets',
          'buffer',
          'nerdfont',
          'ripgrep',
          'npm',
        },
        providers = {
          lsp = {
            name = 'LSP',
            module = 'blink.cmp.sources.lsp',
            -- You may enable the buffer source, when LSP is available, by setting this to `{}`
            -- You may want to set the score_offset of the buffer source to a lower value, such as -5 in this case
            fallbacks = { 'buffer' },
            opts = { tailwind_color_icon = '██' },

            --- These properties apply to !!ALL sources!!
            --- NOTE: All of these options may be functions to get dynamic behavior
            --- See the type definitions for more information
            enabled = true, -- Whether or not to enable the provider
            async = false, -- Whether we should show the completions before this provider returns, without waiting for it
            timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
            transform_items = nil, -- Function to transform the items before they're returned
            should_show_items = true, -- Whether or not to show the items
            max_items = nil, -- Maximum number of items to display in the menu
            -- Minimum number of characters in the keyword to trigger the provider
            -- May also be a function(ctx: blink.cmp.Context): number
            -- To ignore this property when manually showing the menu, set it like:
            -- min_keyword_length = function(ctx) return ctx.trigger.initial_kind == 'manual' and 0 or 1 end
            min_keyword_length = 0,
            -- If this provider returns 0 items, it will fallback to these providers.
            -- If multiple providers fallback to the same provider, all of the providers must return 0 items for it to fallback
            fallbacks = {},
            score_offset = 0, -- Boost/penalize the score of the items
            override = nil, -- Override the source's functions
          },

          path = {
            module = 'blink.cmp.sources.path',
            score_offset = 3,
            fallbacks = { 'buffer' },
            opts = {
              trailing_slash = true,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
              end,
              show_hidden_files_by_default = false,
              -- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
              ignore_root_slash = false,
              -- Maximum number of files/directories to return. This limits memory use and responsiveness for very large folders.
              max_entries = 10000,
            },
          },

          snippets = {
            module = 'blink.cmp.sources.snippets',
            score_offset = -1, -- receives a -3 from top level snippets.score_offset

            -- For `snippets.preset == 'default'`
            opts = {
              friendly_snippets = true,
              search_paths = { vim.fn.stdpath('config') .. '/snippets' },
              global_snippets = { 'all' },
              extended_filetypes = {},
              filter_snippets = function(filetype, file)
                return true
              end,
              get_filetype = function(context)
                return vim.bo.filetype
              end,
              -- Set to '+' to use the system clipboard, or '"' to use the unnamed register
              clipboard_register = nil,
              -- Whether to put the snippet description in the label description
              use_label_description = false,
            },
          },

          buffer = {
            module = 'blink.cmp.sources.buffer',
            score_offset = -3,
            opts = {
              -- default to all visible buffers
              get_bufnrs = function()
                return vim
                  .iter(vim.api.nvim_list_wins())
                  :map(function(win)
                    return vim.api.nvim_win_get_buf(win)
                  end)
                  :filter(function(buf)
                    return vim.bo[buf].buftype ~= 'nofile'
                  end)
                  :totable()
              end,
              -- buffers when searching with `/` or `?`
              get_search_bufnrs = function()
                return { vim.api.nvim_get_current_buf() }
              end,
              -- Maximum total number of characters (in an individual buffer) for which buffer completion runs synchronously. Above this, asynchronous processing is used.
              max_sync_buffer_size = 20000,
              -- Maximum total number of characters (in an individual buffer) for which buffer completion runs asynchronously. Above this, the buffer will be skipped.
              max_async_buffer_size = 200000,
              -- Maximum text size across all buffers (default: 500KB)
              max_total_buffer_size = 500000,
              -- Order in which buffers are retained for completion, up to the max total size limit (see above)
              retention_order = { 'focused', 'visible', 'recency', 'largest' },
              -- Cache words for each buffer which increases memory usage but drastically reduces cpu usage. Memory usage depends on the size of the buffers from `get_bufnrs`. For 100k items, it will use ~20MBs of memory. Invalidated and refreshed whenever the buffer content is modified.
              use_cache = true,
              -- Whether to enable buffer source in substitute (:s), global (:g) and grep commands (:grep, :vimgrep, etc.).
              -- Note: Enabling this option will temporarily disable Neovim's 'inccommand' feature
              -- while editing Ex commands, due to a known redraw issue (see neovim/neovim#9783).
              -- This means you will lose live substitution previews when using :s, :smagic, or :snomagic
              -- while buffer completions are active.
              enable_in_ex_commands = false,
            },
          },

          cmdline = {
            module = 'blink.cmp.sources.cmdline',
          },

          omni = {
            module = 'blink.cmp.sources.complete_func',
            enabled = function()
              return vim.bo.omnifunc ~= 'v:lua.vim.lsp.omnifunc'
            end,
            opts = {
              complete_func = function()
                return vim.bo.omnifunc
              end,
            },
          },

          nerdfont = {
            module = 'blink-nerdfont',
            name = 'Nerd Fonts',
            score_offset = 15, -- Tune by preference
            opts = {
              insert = true, -- Insert nerdfont icon (default) or complete its name
              trigger = ':-)', -- Customize the trigger. Defaults to ":"
            },
          },
          ripgrep = {
            module = 'blink-ripgrep',
            name = 'Ripgrep',
            opts = {},
          },
          npm = {
            name = 'npm',
            module = 'blink-cmp-npm',
            async = true,
            -- optional - make blink-cmp-npm completions top priority (see `:h blink.cmp`)
            score_offset = 100,
            -- optional - blink-cmp-npm config
            opts = {
              ignore = {},
              only_semantic_versions = true,
              only_latest_version = false,
            },
          },
        },
      },
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
  },
}
