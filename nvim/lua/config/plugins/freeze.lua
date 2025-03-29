return {
  'charm-and-friends/freeze.nvim',
  config = function()
    require('freeze').setup {
      command = 'freeze',
      open = true, -- Might set to false later idk yet
      output = function()
        return './' .. os.date '%Y-%m-%d' .. '_freeze.png'
      end,
      theme = 'catppuccin-mocha',
    }
  end,
  vim.keymap.set('v', '<leader>fc', '<cmd>Freeze<cr>', { desc = 'Code imagewith Freeze' }),
}
