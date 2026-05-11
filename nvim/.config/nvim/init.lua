-- Requires Neovim >= 0.12
if vim.fn.has('nvim-0.12') == 0 then
  vim.notify('Config requires Neovim >= 0.12', vim.log.levels.ERROR)
  return
end

require('config.options')
require('config.keymaps')
require('config.autocmds')
require('plugins')
