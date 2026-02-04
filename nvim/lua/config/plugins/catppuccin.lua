return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        integrations = {
          barbar = true,
          blink_cmp = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
