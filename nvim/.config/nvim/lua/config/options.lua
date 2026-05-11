vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

local opt = vim.opt

-- Numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.inccommand = 'split'

-- UI
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.showmode = false
opt.laststatus = 3
opt.pumheight = 12
opt.pumblend = 8
opt.winblend = 8
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.fillchars = {
  foldopen = '▾',
  foldclose = '▸',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
-- 0.12 new options
opt.pumborder = 'rounded'
opt.pummaxwidth = 40

-- Files
opt.undofile = true
opt.undolevels = 10000
opt.backup = false
opt.swapfile = false
opt.confirm = true
opt.autowrite = true

-- Performance
opt.updatetime = 200
opt.timeoutlen = 300

-- Folding (treesitter-based)
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldtext = ''
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Grep
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'

-- Clipboard (deferred to avoid startup freeze)
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

opt.mouse = 'a'
opt.conceallevel = 2
opt.spelllang = { 'en_gb' }
