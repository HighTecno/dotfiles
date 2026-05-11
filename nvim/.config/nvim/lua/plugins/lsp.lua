-- LSP configuration using Neovim 0.12's native vim.lsp.config / vim.lsp.enable
-- Mason handles binary installation; mason bin is added to PATH below.
-- To add a server: vim.lsp.config('name', {...}), then add to vim.lsp.enable({...})

-- Ensure mason-installed binaries are findable
vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

-- ─── Mason ────────────────────────────────────────────────────────────────────
local mason_ok, mason = pcall(require, 'mason')
if mason_ok then
  mason.setup({
    ui = {
      border = 'rounded',
      icons = {
        package_installed   = '✓',
        package_pending     = '➜',
        package_uninstalled = '✗',
      },
    },
    max_concurrent_installers = 4,
  })

  -- Auto-install required tools on first run
  local tools = {
    -- LSP servers
    'lua-language-server', 'typescript-language-server', 'pyright',
    'rust-analyzer', 'clangd', 'bash-language-server',
    'json-lsp', 'html-lsp', 'css-lsp', 'tailwindcss-language-server', 'marksman',
    -- Formatters
    'stylua', 'prettier', 'black', 'isort', 'shfmt',
    -- Linters
    'shellcheck', 'luacheck', 'eslint_d',
  }

  local registry_ok, registry = pcall(require, 'mason-registry')
  if registry_ok then
    registry.refresh(vim.schedule_wrap(function()
      for _, tool in ipairs(tools) do
        local s, pkg = pcall(registry.get_package, tool)
        if s and not pkg:is_installed() then pkg:install() end
      end
    end))
  end
end

-- ─── Fidget (LSP progress) ────────────────────────────────────────────────────
local fidget_ok, fidget = pcall(require, 'fidget')
if fidget_ok then
  fidget.setup({
    progress = {
      display = {
        render_limit = 5,
        done_ttl = 2,
        progress_icon = { pattern = 'dots' },
      },
    },
    notification = {
      window = { winblend = 8, border = 'rounded' },
    },
  })
end

-- ─── Capabilities (shared across all servers) ─────────────────────────────────
local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  -- blink.cmp capabilities if available
  (function()
    local ok, blink = pcall(require, 'blink.cmp')
    return ok and blink.get_lsp_capabilities() or {}
  end)()
)

-- ─── LSP Server Configurations (0.12 native API) ──────────────────────────────

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', 'stylua.toml', '.git' },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file('', true),
      },
      completion   = { callSnippet = 'Replace' },
      telemetry    = { enable = false },
      diagnostics  = { globals = { 'vim' } },
      hint = { enable = true },
    },
  },
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript', 'javascriptreact', 'javascript.jsx',
    'typescript', 'typescriptreact', 'typescript.tsx',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  capabilities = capabilities,
  init_options = {
    hostInfo = 'neovim',
    preferences = {
      includeInlayParameterNameHints = 'all',
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
    },
  },
})

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
        typeCheckingMode = 'basic',
      },
    },
  },
})

vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'Cargo.lock', '.git' },
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      checkOnSave  = { command = 'clippy' },
      inlayHints   = { enable = true },
      cargo        = { allFeatures = true },
      procMacro    = { enable = true },
    },
  },
})

vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--function-arg-placeholders',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'bash', 'sh', 'zsh' },
  root_markers = { '.git' },
  capabilities = capabilities,
  settings = { bashIde = { globPattern = '*@(.sh|.inc|.bash|.command|.zsh)' } },
})

vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { '.git' },
  capabilities = capabilities,
  init_options = { provideFormatter = true },
  settings = {
    json = {
      schemas = (function() local ok, ss = pcall(require, 'schemastore'); return ok and ss.json.schemas() or {} end)(),
      validate = { enable = true },
    },
  },
})

vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html', 'templ' },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
  init_options = { provideFormatter = true },
})

vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
  init_options = { provideFormatter = true },
})

vim.lsp.config('tailwindcss', {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'html', 'css', 'scss',
    'javascript', 'javascriptreact',
    'typescript', 'typescriptreact',
  },
  root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js', 'package.json', '.git' },
  capabilities = capabilities,
})

vim.lsp.config('marksman', {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
  capabilities = capabilities,
})

-- Enable all servers
vim.lsp.enable({
  'lua_ls', 'ts_ls', 'pyright', 'rust_analyzer',
  'clangd', 'bashls', 'jsonls', 'html', 'cssls',
  'tailwindcss', 'marksman',
})

-- ─── Conform (formatting) ─────────────────────────────────────────────────────
local conform_ok, conform = pcall(require, 'conform')
if conform_ok then
  conform.setup({
    formatters_by_ft = {
      lua        = { 'stylua' },
      python     = { 'isort', 'black' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      html  = { 'prettier' },
      css   = { 'prettier' },
      scss  = { 'prettier' },
      json  = { 'prettier' },
      jsonc = { 'prettier' },
      yaml  = { 'prettier' },
      markdown = { 'prettier' },
      rust  = { 'rustfmt' },
      c     = { 'clang_format' },
      cpp   = { 'clang_format' },
      sh    = { 'shfmt' },
      bash  = { 'shfmt' },
      zsh   = { 'shfmt' },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    },
    formatters = {
      shfmt = { args = { '-i', '2', '-ci' } },
    },
  })

  vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
    conform.format({ async = true, lsp_fallback = true })
  end, { desc = 'Format buffer' })
end

-- ─── nvim-lint ────────────────────────────────────────────────────────────────
local lint_ok, lint = pcall(require, 'lint')
if lint_ok then
  lint.linters_by_ft = {
    javascript      = { 'eslint_d' },
    typescript      = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    lua             = { 'luacheck' },
    python          = { 'pylint' },
    sh              = { 'shellcheck' },
    bash            = { 'shellcheck' },
  }

  local lint_group = vim.api.nvim_create_augroup('nvim_lint', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
    group = lint_group,
    callback = function()
      lint.try_lint()
    end,
  })

  vim.keymap.set('n', '<leader>li', function() lint.try_lint() end, { desc = 'Run linter' })
end
