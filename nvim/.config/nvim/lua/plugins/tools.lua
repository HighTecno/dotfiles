local function setup(name, fn)
  local ok, mod = pcall(require, name)
  if ok then fn(mod) end
end

-- ─── Which-key ────────────────────────────────────────────────────────────────
setup('which-key', function(wk)
  wk.setup({
    preset = 'modern',
    delay  = 400,
    icons  = {
      breadcrumb = '»',
      separator  = '➜',
      group      = '+',
      ellipsis   = '…',
      colors     = true,
    },
    win = { border = 'rounded' },
    spec = {
      { '<leader>b',     group = 'buffers',          icon = '󰈔' },
      { '<leader>c',     group = 'code',             icon = '' },
      { '<leader>f',     group = 'find / files',     icon = '' },
      { '<leader>g',     group = 'git',              icon = '' },
      { '<leader>h',     group = 'hunks',            icon = '' },
      { '<leader>l',     group = 'lsp / lint',       icon = '' },
      { '<leader>s',     group = 'search',           icon = '' },
      { '<leader>t',     group = 'terminal',         icon = '' },
      { '<leader>u',     group = 'ui',               icon = '󰙵' },
      { '<leader>w',     group = 'windows',          icon = '󱂬' },
      { '<leader>x',     group = 'diagnostics',      icon = '' },
      { '<leader><tab>', group = 'tabs',             icon = '󰓩' },
      { 'g',             group = 'goto',             icon = '' },
      { 'z',             group = 'fold',             icon = '󰁃' },
      { '[',             group = 'prev',             icon = '' },
      { ']',             group = 'next',             icon = '' },
    },
  })

  -- UI toggles
  local map = vim.keymap.set
  map('n', '<leader>ub', '<cmd>lua require("bufferline").toggle()<CR>',  { desc = 'Toggle bufferline' })
  map('n', '<leader>ud', function()
    if vim.diagnostic.is_enabled() then
      vim.diagnostic.enable(false)
      vim.notify('Diagnostics disabled', vim.log.levels.INFO)
    else
      vim.diagnostic.enable()
      vim.notify('Diagnostics enabled', vim.log.levels.INFO)
    end
  end, { desc = 'Toggle diagnostics' })
  map('n', '<leader>ul', '<cmd>set list!<CR>',                           { desc = 'Toggle listchars' })
  map('n', '<leader>uw', '<cmd>set wrap!<CR>',                           { desc = 'Toggle wrap' })
  map('n', '<leader>us', '<cmd>set spell!<CR>',                          { desc = 'Toggle spell' })
  map('n', '<leader>un', '<cmd>set relativenumber!<CR>',                 { desc = 'Toggle rel numbers' })
  map('n', '<leader>uc', '<cmd>set cursorline!<CR>',                     { desc = 'Toggle cursorline' })
end)

-- ─── Oil (file explorer) ──────────────────────────────────────────────────────
setup('oil', function(oil)
  oil.setup({
    default_file_explorer = true,
    columns = {
      { 'icon', default_file = '' },
      'permissions',
      'size',
      'mtime',
    },
    buf_options = { buflisted = false, bufhidden = 'hide' },
    win_options = {
      wrap = false,
      signcolumn = 'no',
      cursorcolumn = false,
      foldcolumn = '0',
      spell = false,
      number = false,
      relativenumber = false,
      statuscolumn = '',
    },
    restore_win_options = true,
    skip_confirm_for_simple_edits = false,
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name)
        return vim.startswith(name, '.')
      end,
    },
    float = {
      padding = 2,
      border = 'rounded',
    },
    keymaps = {
      ['g?']    = 'actions.show_help',
      ['<CR>']  = 'actions.select',
      ['<C-s>'] = false,
      ['<C-h>'] = false,
      ['<C-v>'] = 'actions.select_vsplit',
      ['<C-x>'] = 'actions.select_split',
      ['<C-t>'] = 'actions.select_tab',
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = 'actions.close',
      ['<C-l>'] = false,
      ['<C-r>'] = 'actions.refresh',
      ['-']     = 'actions.parent',
      ['_']     = 'actions.open_cwd',
      ['`']     = 'actions.cd',
      ['~']     = 'actions.tcd',
      ['gs']    = 'actions.change_sort',
      ['gx']    = 'actions.open_external',
      ['g.']    = 'actions.toggle_hidden',
    },
  })

  vim.keymap.set('n', '-',          '<cmd>Oil<CR>',              { desc = 'Open parent dir (oil)' })
  vim.keymap.set('n', '<leader>e',  '<cmd>Oil<CR>',              { desc = 'File explorer' })
  vim.keymap.set('n', '<leader>E',  function()
    require('oil').toggle_float()
  end, { desc = 'File explorer (float)' })
end)

-- ─── Toggleterm ───────────────────────────────────────────────────────────────
setup('toggleterm', function(tt)
  tt.setup({
    size = function(term)
      if term.direction == 'horizontal' then return 15
      elseif term.direction == 'vertical' then return math.floor(vim.o.columns * 0.4)
      end
    end,
    open_mapping  = [[<C-\>]],
    hide_numbers  = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    persist_mode  = true,
    direction     = 'float',
    close_on_exit = true,
    shell         = vim.o.shell,
    auto_scroll   = true,
    float_opts = {
      border   = 'curved',
      winblend = 3,
    },
    highlights = {
      FloatBorder = { link = 'FloatBorder' },
      NormalFloat = { link = 'NormalFloat' },
    },
  })

  local Terminal = require('toggleterm.terminal').Terminal

  local lazygit = Terminal:new({
    cmd = 'lazygit',
    dir = 'git_dir',
    direction = 'float',
    hidden = true,
    float_opts = { border = 'curved' },
  })

  vim.keymap.set('n', '<leader>gg', function() lazygit:toggle() end, { desc = 'Lazygit' })
  vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>',           { desc = 'Toggle terminal' })
  vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Terminal horizontal' })
  vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>',   { desc = 'Terminal vertical' })
  vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>',      { desc = 'Terminal float' })
end)

-- ─── Trouble ──────────────────────────────────────────────────────────────────
setup('trouble', function(trouble)
  trouble.setup({
    modes = {
      lsp = {
        win = { position = 'right', size = 0.35 },
      },
      symbols = {
        win = { position = 'right', size = 0.35 },
      },
    },
    icons = {
      indent = {
        fold_open  = ' ',
        fold_closed = ' ',
      },
      folder_closed = '',
      folder_open   = '',
      kinds = {
        Array         = ' ',
        Boolean       = '󰨙 ',
        Class         = ' ',
        Constant      = '󰏿 ',
        Constructor   = ' ',
        Enum          = ' ',
        EnumMember    = ' ',
        Event         = ' ',
        Field         = ' ',
        File          = ' ',
        Function      = '󰊕 ',
        Interface     = ' ',
        Key           = ' ',
        Method        = '󰊕 ',
        Module        = ' ',
        Namespace     = '󰦮 ',
        Null          = '󰟢 ',
        Number        = '󰎠 ',
        Object        = ' ',
        Operator      = ' ',
        Package       = ' ',
        Property      = ' ',
        String        = ' ',
        Struct        = '󰆼 ',
        TypeParameter = '󰬛 ',
        Variable      = '󰆦 ',
      },
    },
  })

  local map = vim.keymap.set
  map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>',              { desc = 'Diagnostics' })
  map('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Buffer diagnostics' })
  map('n', '<leader>xs', '<cmd>Trouble symbols toggle<CR>',                  { desc = 'Symbols' })
  map('n', '<leader>xl', '<cmd>Trouble loclist toggle<CR>',                  { desc = 'Location list' })
  map('n', '<leader>xq', '<cmd>Trouble qflist toggle<CR>',                   { desc = 'Quickfix list' })
  map('n', '<leader>xr', '<cmd>Trouble lsp_references toggle<CR>',           { desc = 'LSP references' })
  map('n', '[x', function() trouble.prev({ skip_groups = true, jump = true }) end, { desc = 'Prev trouble item' })
  map('n', ']x', function() trouble.next({ skip_groups = true, jump = true }) end, { desc = 'Next trouble item' })
end)
