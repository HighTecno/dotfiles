local function setup(name, fn)
  local ok, mod = pcall(require, name)
  if ok then fn(mod) end
end

-- ─── Moonstone colorscheme ────────────────────────────────────────────────────
vim.cmd.colorscheme('moonstone')

-- ─── nvim-notify ──────────────────────────────────────────────────────────────
setup('notify', function(n)
  n.setup({
    background_colour = '#0f1014',
    fps = 60,
    icons = { ERROR = '', WARN = '', INFO = '', DEBUG = '', TRACE = '✎' },
    render = 'wrapped-compact',
    stages = 'fade_in_slide_out',
    timeout = 3000,
    top_down = true,
    max_width = 60,
  })
  vim.notify = n
end)

-- ─── Noice ────────────────────────────────────────────────────────────────────
setup('noice', function(n)
  n.setup({
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
      hover     = { enabled = true },
      signature = { enabled = true },
      progress  = { enabled = true, throttle = 1000 / 30 },
    },
    presets = {
      bottom_search        = true,
      command_palette      = true,
      long_message_to_split = true,
      lsp_doc_border       = true,
    },
    routes = {
      { filter = { event = 'msg_show', kind = '', find = 'written' },      opts = { skip = true } },
      { filter = { event = 'msg_show', kind = '', find = 'fewer lines' },  opts = { skip = true } },
      { filter = { event = 'msg_show', kind = '', find = 'more lines' },   opts = { skip = true } },
    },
  })

  vim.keymap.set('n', '<leader>sn', function() n.cmd('Telescope noice') end, { desc = 'Noice history' })
  vim.keymap.set('c', '<S-Enter>', function() n.redirect(vim.fn.getcmdline()) end, { desc = 'Redirect to Noice' })
end)

-- ─── Lualine ──────────────────────────────────────────────────────────────────
setup('lualine', function(l)
  local noice_ok, noice = pcall(require, 'noice')

  l.setup({
    options = {
      theme = {
        normal   = { a = { fg = '#0f1014', bg = '#8d97a8', gui = 'bold' }, b = { fg = '#c0c8d4', bg = '#1e2228' }, c = { fg = '#a8b2be', bg = '#1a1d24' } },
        insert   = { a = { fg = '#0f1014', bg = '#dce0e8', gui = 'bold' }, b = { fg = '#c0c8d4', bg = '#1e2228' }, c = { fg = '#a8b2be', bg = '#1a1d24' } },
        visual   = { a = { fg = '#0f1014', bg = '#9fa8b6', gui = 'bold' }, b = { fg = '#c0c8d4', bg = '#1e2228' }, c = { fg = '#a8b2be', bg = '#1a1d24' } },
        replace  = { a = { fg = '#0f1014', bg = '#7c8898', gui = 'bold' }, b = { fg = '#c0c8d4', bg = '#1e2228' }, c = { fg = '#a8b2be', bg = '#1a1d24' } },
        command  = { a = { fg = '#0f1014', bg = '#b8c0ca', gui = 'bold' }, b = { fg = '#c0c8d4', bg = '#1e2228' }, c = { fg = '#a8b2be', bg = '#1a1d24' } },
        inactive = { a = { fg = '#5d6676', bg = '#1a1d24'               }, b = { fg = '#5d6676', bg = '#1a1d24' }, c = { fg = '#5d6676', bg = '#1a1d24' } },
      },
      globalstatus = true,
      disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
      component_separators = { left = '', right = '' },
      section_separators   = { left = '', right = '' },
    },
    sections = {
      lualine_a = { { 'mode', fmt = function(s) return ' ' .. s end } },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        { 'filename', path = 1, symbols = { modified = '  ', readonly = ' ', unnamed = ' ' } },
      },
      lualine_x = {
        noice_ok and {
          function() return noice.api.status.command.get() end,
          cond = function() return noice.api.status.command.has() end,
          color = { fg = '#9fa8b6' },
        } or nil,
        noice_ok and {
          function() return noice.api.status.mode.get() end,
          cond = function() return noice.api.status.mode.has() end,
          color = { fg = '#8d97a8' },
        } or nil,
        'encoding',
        { 'fileformat', symbols = { unix = '', dos = '', mac = '' } },
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { { 'location', fmt = function(s) return ' ' .. s end } },
    },
    extensions = { 'oil', 'trouble', 'toggleterm', 'quickfix' },
  })
end)

-- ─── Bufferline ───────────────────────────────────────────────────────────────
setup('bufferline', function(b)
  b.setup({
    options = {
      mode            = 'buffers',
      numbers         = 'none',
      diagnostics     = 'nvim_lsp',
      diagnostics_indicator = function(count, level)
        return ' ' .. (level:match('error') and ' ' or ' ') .. count
      end,
      offsets = {
        { filetype = 'oil', text = 'File Explorer', text_align = 'left', separator = true },
      },
      show_buffer_close_icons = true,
      show_close_icon         = true,
      color_icons             = true,
      separator_style         = 'slant',
      hover = { enabled = true, delay = 200, reveal = { 'close' } },
    },
  })

  local map = vim.keymap.set
  map('n', '<leader>bp', '<cmd>BufferLinePick<CR>',         { desc = 'Pick buffer' })
  map('n', '<leader>bP', '<cmd>BufferLinePickClose<CR>',    { desc = 'Pick close buffer' })
  map('n', '<leader>bl', '<cmd>BufferLineCloseRight<CR>',   { desc = 'Close right buffers' })
  map('n', '<leader>bh', '<cmd>BufferLineCloseLeft<CR>',    { desc = 'Close left buffers' })
  map('n', '[b', '<cmd>BufferLineCyclePrev<CR>',            { desc = 'Prev buffer' })
  map('n', ']b', '<cmd>BufferLineCycleNext<CR>',            { desc = 'Next buffer' })
end)

-- ─── Dressing ─────────────────────────────────────────────────────────────────
setup('dressing', function(d)
  d.setup({
    input = {
      default_prompt = '➤ ',
      win_options = { winblend = 8 },
    },
    select = { backend = { 'telescope', 'builtin' } },
  })
end)

-- ─── Indent Blankline ─────────────────────────────────────────────────────────
setup('ibl', function(ibl)
  ibl.setup({
    indent = { char = '│', tab_char = '│' },
    scope = { enabled = true, show_start = true, show_end = false },
    exclude = {
      filetypes = { 'help', 'alpha', 'dashboard', 'oil', 'trouble', 'notify', 'lazy', 'mason' },
    },
  })
end)

-- ─── Todo Comments ────────────────────────────────────────────────────────────
setup('todo-comments', function(t)
  t.setup({ signs = true, search = { command = 'rg' } })
  vim.keymap.set('n', ']t', function() t.jump_next() end, { desc = 'Next TODO' })
  vim.keymap.set('n', '[t', function() t.jump_prev() end, { desc = 'Prev TODO' })
  vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<CR>', { desc = 'Find TODOs' })
end)

-- ─── Illuminate ───────────────────────────────────────────────────────────────
setup('illuminate', function(i)
  i.configure({
    providers = { 'lsp', 'treesitter', 'regex' },
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = { providers = { 'lsp' } },
    min_count_to_highlight = 2,
  })
end)

-- ─── Scrollbar ────────────────────────────────────────────────────────────────
setup('scrollbar', function(s)
  s.setup({
    show = true,
    show_in_active_only = false,
    set_highlights = true,
    folds = 1000,
    handle = { color = '#585b70' },
    marks = {
      Error = { text = { '-', '=' } },
      Warn  = { text = { '-', '=' } },
      Info  = { text = { '-', '=' } },
      Hint  = { text = { '-', '=' } },
    },
  })
end)

-- ─── Alpha Dashboard ──────────────────────────────────────────────────────────
setup('alpha', function(alpha)
  local dashboard = require('alpha.themes.dashboard')

  dashboard.section.header.val = {
    '                                                     ',
    '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
    '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
    '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
    '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
    '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
    '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
    '                                                     ',
  }

  dashboard.section.buttons.val = {
    dashboard.button('f', '  Find file',    '<cmd>Telescope find_files<CR>'),
    dashboard.button('r', '  Recent files', '<cmd>Telescope oldfiles<CR>'),
    dashboard.button('g', '  Grep text',    '<cmd>Telescope live_grep<CR>'),
    dashboard.button('c', '  Config',       '<cmd>edit $MYVIMRC<CR>'),
    dashboard.button('l', '󰒲  Plugins',      '<cmd>lua vim.pack.update()<CR>'),
    dashboard.button('q', '  Quit',         '<cmd>qa<CR>'),
  }

  dashboard.section.header.opts.hl = 'AlphaHeader'
  dashboard.section.buttons.opts.hl = 'AlphaButtons'

  alpha.setup(dashboard.config)

  -- Don't show statusline on dashboard
  vim.api.nvim_create_autocmd('User', {
    pattern = 'AlphaReady',
    callback = function() vim.opt_local.laststatus = 0 end,
  })
  vim.api.nvim_create_autocmd('BufUnload', {
    pattern = '<buffer>',
    callback = function() vim.opt_local.laststatus = 3 end,
  })
end)
