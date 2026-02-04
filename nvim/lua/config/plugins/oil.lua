return {
  'stevearc/oil.nvim',
  keys = {
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
  },
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
  },
  lazy = false,
}
