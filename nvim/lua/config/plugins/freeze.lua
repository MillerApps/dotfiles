return {
  'charm-and-friends/freeze.nvim',
  keys = {
    { '<leader>fc', '<cmd>Freeze<cr>', mode = 'v', desc = 'Code image with Freeze' },
  },
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
}
