return {
  'stevearc/oil.nvim',
  opts = {},
  lazy = false,
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
}
