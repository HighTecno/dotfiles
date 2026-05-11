local function setup(name, fn)
  local ok, mod = pcall(require, name)
  if ok then fn(mod) end
end

-- ─── Treesitter ───────────────────────────────────────────────────────────────
setup('nvim-treesitter.configs', function(ts)
  ts.setup({
    ensure_installed = {
      'bash', 'c', 'cpp', 'css', 'diff', 'html', 'javascript', 'json', 'jsonc',
      'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'query',
      'regex', 'rust', 'scss', 'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 'yaml',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection   = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start     = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
        goto_next_end       = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
        goto_previous_end   = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
      },
      swap = {
        enable = true,
        swap_next     = { ['<leader>a'] = '@parameter.inner' },
        swap_previous = { ['<leader>A'] = '@parameter.inner' },
      },
    },
  })
end)

-- ─── Autopairs ────────────────────────────────────────────────────────────────
setup('nvim-autopairs', function(ap)
  ap.setup({
    check_ts = true,
    ts_config = { lua = { 'string' }, javascript = { 'template_string' } },
    fast_wrap = {
      map    = '<M-e>',
      chars  = { '{', '[', '(', '"', "'" },
      end_key = '$',
      highlight = 'PmenuSel',
    },
  })
end)

-- ─── TS Autotag ───────────────────────────────────────────────────────────────
setup('nvim-ts-autotag', function(at)
  at.setup()
end)

-- ─── Comment.nvim ─────────────────────────────────────────────────────────────
setup('Comment', function(c)
  c.setup({
    padding = true,
    sticky = true,
    toggler   = { line = 'gcc', block = 'gbc' },
    opleader  = { line = 'gc',  block = 'gb' },
    extra     = { above = 'gcO', below = 'gco', eol = 'gcA' },
    mappings  = { basic = true, extra = true },
  })
end)

-- ─── nvim-surround ────────────────────────────────────────────────────────────
setup('nvim-surround', function(s)
  s.setup()
end)

-- ─── Flash ────────────────────────────────────────────────────────────────────
setup('flash', function(f)
  f.setup({
    modes = {
      char = { enabled = true, highlight = { backdrop = false } },
      search = { enabled = false },
    },
    label = { rainbow = { enabled = true, shade = 5 } },
  })

  local map = vim.keymap.set
  map({ 'n', 'x', 'o' }, 's',     function() f.jump() end,         { desc = 'Flash jump' })
  map({ 'n', 'x', 'o' }, 'S',     function() f.treesitter() end,   { desc = 'Flash treesitter' })
  map('o',               'r',     function() f.remote() end,       { desc = 'Flash remote' })
  map({ 'o', 'x' },      'R',     function() f.treesitter_search() end, { desc = 'Flash ts search' })
  map('c',               '<C-s>', function() f.toggle() end,       { desc = 'Flash toggle' })
end)

-- ─── Better Escape ────────────────────────────────────────────────────────────
setup('better_escape', function(be)
  be.setup({ timeout = vim.o.timeoutlen, default_mappings = true })
end)
