--------------------------------------------------------------------------------
--  Install `lazy.nvim` Plugin Manager
--------------------------------------------------------------------------------
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
--  Configure and Install Plugins via Lazy
--------------------------------------------------------------------------------
--    :Lazy          -- to see the plugin status
--    :Lazy update   -- to update all plugins
--------------------------------------------------------------------------------
require('lazy').setup {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  --------------------------------------------------------------------------------
  -- Import Custom Plugins from 'lua/custom/plugins/*.lua'
  --------------------------------------------------------------------------------
  { import = 'config.plugins' },
  --------------------------------------------------------------------------------
  -- set keybindings
  --------------------------------------------------------------------------------
  vim.keymap.set('n', '<leader>l', ':Lazy<CR>', { noremap = true, silent = true }),
}
