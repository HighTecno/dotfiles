local function au(name)
  return vim.api.nvim_create_augroup('user_' .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = au('yank_highlight'),
  callback = function() vim.highlight.on_yank() end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  group = au('restore_cursor'),
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lines = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lines then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Close utility buffers with q
vim.api.nvim_create_autocmd('FileType', {
  group = au('close_with_q'),
  pattern = { 'help', 'man', 'qf', 'lspinfo', 'startuptime', 'checkhealth', 'notify', 'git' },
  callback = function(ev)
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = ev.buf, silent = true })
  end,
})

-- Equalize splits on resize
vim.api.nvim_create_autocmd('VimResized', {
  group = au('resize_splits'),
  callback = function() vim.cmd('tabdo wincmd =') end,
})

-- Check for external file changes
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = au('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then vim.cmd('checktime') end
  end,
})

-- Spell + wrap in prose buffers
vim.api.nvim_create_autocmd('FileType', {
  group = au('prose'),
  pattern = { 'markdown', 'text', 'gitcommit' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto-create parent directories on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = au('auto_mkdir'),
  callback = function(ev)
    if ev.match:match('^%w%w+://') then return end
    local dir = vim.fn.fnamemodify(vim.fn.expand('<afile>'), ':p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- LSP keymaps on attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = au('lsp_attach'),
  callback = function(ev)
    local buf = ev.buf
    local function map(key, fn, desc)
      vim.keymap.set('n', key, fn, { buffer = buf, desc = 'LSP: ' .. desc })
    end

    map('gd', vim.lsp.buf.definition, 'Definition')
    map('gD', vim.lsp.buf.declaration, 'Declaration')
    map('gi', vim.lsp.buf.implementation, 'Implementation')
    map('gr', vim.lsp.buf.references, 'References')
    map('gy', vim.lsp.buf.type_definition, 'Type definition')
    map('K', vim.lsp.buf.hover, 'Hover docs')
    map('gK', vim.lsp.buf.signature_help, 'Signature help')
    map('<leader>cr', vim.lsp.buf.rename, 'Rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('<leader>cA', function()
      vim.lsp.buf.code_action({ context = { only = { 'source' }, diagnostics = {} } })
    end, 'Source action')
    -- 0.12 codelens (default: grx, adding extra binding)
    map('<leader>cl', vim.lsp.codelens.run, 'Run codelens')
    map('<leader>cL', vim.lsp.codelens.refresh, 'Refresh codelens')

    -- Inlay hints toggle (if supported)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.supports_method('textDocument/inlayHint') then
      map('<leader>ch', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
      end, 'Toggle inlay hints')
    end
  end,
})

-- Diagnostic display config (0.12: signs no longer via sign-define)
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    source = 'if_many',
    prefix = '●',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN]  = '',
      [vim.diagnostic.severity.HINT]  = '󰌵',
      [vim.diagnostic.severity.INFO]  = '',
    },
  },
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  update_in_insert = false,
  severity_sort = true,
  underline = true,
})
