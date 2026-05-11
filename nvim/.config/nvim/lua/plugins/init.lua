-- Native plugin management — Neovim 0.12+ (vim.pack)
-- First run: installs plugins, then restart nvim.
-- Update: :lua vim.pack.update()
-- Remove: remove from list below, restart, then :lua vim.pack.del({'name'})

-- Build hooks for plugins that need compilation
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack_build_hooks', { clear = true }),
  callback = function(ev)
    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then return end
    local name = ev.data.spec.name
    local path = ev.data.path

    if name == 'telescope-fzf-native' then
      vim.system({ 'make' }, { cwd = path }, function(r)
        if r.code ~= 0 then
          vim.schedule(function() vim.notify('fzf-native build failed', vim.log.levels.WARN) end)
        end
      end)
    end

    if name == 'blink-cmp' then
      vim.system({ 'cargo', 'build', '--release' }, { cwd = path }, function(r)
        if r.code ~= 0 then
          vim.schedule(function()
            vim.notify('blink.cmp build failed (cargo required). Completion may be limited.', vim.log.levels.WARN)
          end)
        end
      end)
    end
  end,
})

local pack_ok, pack_err = pcall(vim.pack.add, {
  -- Deps (loaded first by other plugins)
  { src = 'https://github.com/nvim-lua/plenary.nvim',         name = 'plenary' },
  { src = 'https://github.com/MunifTanjim/nui.nvim',          name = 'nui' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons',   name = 'nvim-web-devicons' },

  -- UI
  { src = 'https://github.com/nvim-lualine/lualine.nvim',              name = 'lualine' },
  { src = 'https://github.com/akinsho/bufferline.nvim',                name = 'bufferline' },
  { src = 'https://github.com/rcarriga/nvim-notify',                   name = 'nvim-notify' },
  { src = 'https://github.com/folke/noice.nvim',                       name = 'noice' },
  { src = 'https://github.com/stevearc/dressing.nvim',                 name = 'dressing' },
  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim',    name = 'indent-blankline' },
  { src = 'https://github.com/folke/todo-comments.nvim',               name = 'todo-comments' },
  { src = 'https://github.com/RRethy/vim-illuminate',                  name = 'vim-illuminate' },
  { src = 'https://github.com/goolord/alpha-nvim',                     name = 'alpha-nvim' },
  { src = 'https://github.com/petertriho/nvim-scrollbar',              name = 'nvim-scrollbar' },

  -- Editor
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter',                  name = 'nvim-treesitter' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',      name = 'ts-textobjects' },
  { src = 'https://github.com/windwp/nvim-autopairs',                            name = 'nvim-autopairs' },
  { src = 'https://github.com/windwp/nvim-ts-autotag',                           name = 'nvim-ts-autotag' },
  { src = 'https://github.com/numToStr/Comment.nvim',                            name = 'comment' },
  { src = 'https://github.com/kylechui/nvim-surround',                           name = 'nvim-surround' },
  { src = 'https://github.com/folke/flash.nvim',                                 name = 'flash' },
  { src = 'https://github.com/max397574/better-escape.nvim',                     name = 'better-escape' },
  { src = 'https://github.com/mbbill/undotree',                                  name = 'undotree' },

  -- Completion (blink.cmp — requires cargo for first build)
  { src = 'https://github.com/saghen/blink.cmp',              name = 'blink-cmp', version = vim.version.range('0') },
  { src = 'https://github.com/rafamadriz/friendly-snippets',  name = 'friendly-snippets' },

  -- LSP & tooling
  { src = 'https://github.com/williamboman/mason.nvim',  name = 'mason' },
  { src = 'https://github.com/stevearc/conform.nvim',    name = 'conform' },
  { src = 'https://github.com/mfussenegger/nvim-lint',   name = 'nvim-lint' },
  { src = 'https://github.com/j-hui/fidget.nvim',        name = 'fidget' },

  -- Telescope
  { src = 'https://github.com/nvim-telescope/telescope.nvim',                name = 'telescope' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',     name = 'telescope-fzf-native' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim',      name = 'telescope-ui-select' },

  -- Git
  { src = 'https://github.com/lewis6991/gitsigns.nvim',   name = 'gitsigns' },
  { src = 'https://github.com/NeogitOrg/neogit',          name = 'neogit' },
  { src = 'https://github.com/sindrets/diffview.nvim',    name = 'diffview' },

  -- Tools
  { src = 'https://github.com/folke/which-key.nvim',       name = 'which-key' },
  { src = 'https://github.com/akinsho/toggleterm.nvim',    name = 'toggleterm' },
  { src = 'https://github.com/stevearc/oil.nvim',          name = 'oil' },
  { src = 'https://github.com/folke/trouble.nvim',         name = 'trouble' },
})

if not pack_ok then
  if pack_err and pack_err:find('timeout') then
    vim.notify(
      'vim.pack.add timed out — plugins are still installing.\nRestart Neovim once installation finishes.',
      vim.log.levels.WARN
    )
  else
    vim.notify('vim.pack.add error: ' .. tostring(pack_err), vim.log.levels.ERROR)
  end
  return
end

-- Load all plugin configurations
require('plugins.ui')
require('plugins.editor')
require('plugins.completion')
require('plugins.lsp')
require('plugins.telescope')
require('plugins.git')
require('plugins.tools')
