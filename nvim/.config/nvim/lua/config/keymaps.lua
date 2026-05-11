local map = vim.keymap.set

-- Clear highlights
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Respect line wrap for j/k
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Window right' })

-- Window resize
map('n', '<C-Up>', '<cmd>resize +2<CR>')
map('n', '<C-Down>', '<cmd>resize -2<CR>')
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>')
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>')

-- Buffer navigation
map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
map('n', '<leader>bD', '<cmd>bdelete!<CR>', { desc = 'Force delete buffer' })
map('n', '<leader>bo', '<cmd>%bdelete|edit#|bdelete#<CR>', { desc = 'Close other buffers' })

-- Move lines
map('n', '<A-j>', '<cmd>m .+1<CR>==')
map('n', '<A-k>', '<cmd>m .-2<CR>==')
map('i', '<A-j>', '<Esc><cmd>m .+1<CR>==gi')
map('i', '<A-k>', '<Esc><cmd>m .-2<CR>==gi')
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Keep selection when indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Paste without overwriting register
map('v', 'p', '"_dP')

-- Yank to EOL (like C, D)
map('n', 'Y', 'yg$')

-- Quickfix
map('n', '[q', '<cmd>cprev<CR>', { desc = 'Prev quickfix' })
map('n', ']q', '<cmd>cnext<CR>', { desc = 'Next quickfix' })
map('n', '[Q', '<cmd>cfirst<CR>', { desc = 'First quickfix' })
map('n', ']Q', '<cmd>clast<CR>', { desc = 'Last quickfix' })

-- Diagnostics (0.12 uses vim.diagnostic.jump)
map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Next diagnostic' })
map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Prev diagnostic' })
map('n', ']e', function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Next error' })
map('n', '[e', function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Prev error' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic' })

-- File ops
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<leader>W', '<cmd>wa<CR>', { desc = 'Save all' })
map('n', '<leader>Q', '<cmd>qa<CR>', { desc = 'Quit all' })

-- Splits
map('n', '<leader>-', '<C-w>s', { desc = 'Split horizontal' })
map('n', '<leader>|', '<C-w>v', { desc = 'Split vertical' })
map('n', '<leader>wd', '<cmd>close<CR>', { desc = 'Close window' })

-- Tabs
map('n', '<leader><tab>n', '<cmd>tabnew<CR>', { desc = 'New tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<CR>', { desc = 'Close tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<CR>', { desc = 'Prev tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<CR>', { desc = 'Next tab' })

-- Terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal' })

-- Undo tree
map('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Undo tree' })
