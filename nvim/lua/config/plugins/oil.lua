return {
  'stevearc/oil.nvim',
  opts = {
    delete_to_trash = true,
    skip_confrim_fro_simple_edits = true,
  },
  lazy = false,
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
}
