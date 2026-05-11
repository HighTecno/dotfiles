local function setup(name, fn)
  local ok, mod = pcall(require, name)
  if ok then fn(mod) end
end

-- ─── Gitsigns ─────────────────────────────────────────────────────────────────
setup('gitsigns', function(gs)
  gs.setup({
    signs = {
      add          = { text = '▎' },
      change       = { text = '▎' },
      delete       = { text = '' },
      topdelete    = { text = '' },
      changedelete = { text = '▎' },
      untracked    = { text = '▎' },
    },
    signs_staged = {
      add          = { text = '▎' },
      change       = { text = '▎' },
      delete       = { text = '' },
      topdelete    = { text = '' },
      changedelete = { text = '▎' },
    },
    signcolumn = true,
    numhl      = false,
    linehl     = false,
    word_diff  = false,
    watch_gitdir     = { follow_files = true },
    attach_to_untracked = true,
    current_line_blame  = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 500,
    },
    preview_config = { border = 'rounded' },

    on_attach = function(buf)
      local map = function(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buf, desc = 'Git: ' .. desc })
      end

      -- Navigation
      map('n', ']h', function()
        if vim.wo.diff then return ']h' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, 'Next hunk')
      map('n', '[h', function()
        if vim.wo.diff then return '[h' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, 'Prev hunk')

      -- Actions
      map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>',  'Stage hunk')
      map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>',  'Reset hunk')
      map('n', '<leader>hS', gs.stage_buffer,                       'Stage buffer')
      map('n', '<leader>hu', gs.undo_stage_hunk,                    'Undo stage hunk')
      map('n', '<leader>hR', gs.reset_buffer,                       'Reset buffer')
      map('n', '<leader>hp', gs.preview_hunk,                       'Preview hunk')
      map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame line')
      map('n', '<leader>hB', gs.toggle_current_line_blame,          'Toggle blame')
      map('n', '<leader>hd', gs.diffthis,                           'Diff this')
      map('n', '<leader>hD', function() gs.diffthis('~') end,       'Diff this~')

      -- Text object: ih = inner hunk
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Select hunk')
    end,
  })
end)

-- ─── Neogit ───────────────────────────────────────────────────────────────────
setup('neogit', function(ng)
  ng.setup({
    graph_style = 'unicode',
    integrations = {
      diffview = true,
      telescope = true,
    },
    signs = {
      hunk    = { '', '' },
      item    = { '', '' },
      section = { '', '' },
    },
  })

  vim.keymap.set('n', '<leader>gn', '<cmd>Neogit<CR>', { desc = 'Open Neogit' })
  vim.keymap.set('n', '<leader>gl', '<cmd>Neogit log<CR>', { desc = 'Git log' })
  vim.keymap.set('n', '<leader>gp', '<cmd>Neogit push<CR>', { desc = 'Git push' })
end)

-- ─── Diffview ─────────────────────────────────────────────────────────────────
setup('diffview', function(dv)
  dv.setup({
    enhanced_diff_hl = true,
    view = {
      default = { layout = 'diff2_horizontal' },
      merge_tool = { layout = 'diff3_horizontal', disable_diagnostics = true },
    },
    file_panel = {
      listing_style = 'tree',
      tree_options  = { flatten_dirs = true, folder_statuses = 'only_folded' },
    },
    hooks = {
      diff_buf_win_enter = function(_, _, ctx)
        if ctx.layout_name:match('^diff2') then
          if ctx.symbol == 'a' then
            vim.opt_local.winhl = 'Normal:DiffviewNormal,SignColumn:DiffviewNormal'
          end
        end
      end,
    },
  })

  local map = vim.keymap.set
  map('n', '<leader>gd', '<cmd>DiffviewOpen<CR>',          { desc = 'Diff view open' })
  map('n', '<leader>gD', '<cmd>DiffviewClose<CR>',         { desc = 'Diff view close' })
  map('n', '<leader>gh', '<cmd>DiffviewFileHistory<CR>',   { desc = 'File history' })
  map('n', '<leader>gH', '<cmd>DiffviewFileHistory %<CR>', { desc = 'Buffer history' })
end)
