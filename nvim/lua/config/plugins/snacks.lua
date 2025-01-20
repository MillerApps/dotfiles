return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dim = { enabled = true },
    terminal = { enabled = true },
    lazygit = { enabled = true },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    bigfile = { enabled = false },
    dashboard = {
      enabled = true,
      example = 'compact_files',
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = {
      enabled = true,
      notify_jump = true,
      notify_end = true,
    },
  },
  keys = {
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>gf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Lazygit Current File History',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit Log (cwd)',
    },
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<a-t>',
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    {
      '<leader>dd',
      function()
        Snacks.dim()
      end,
      desc = 'Dim On',
    },
    {
      '<leader>do',
      function()
        Snacks.dim.disable()
      end,
      desc = 'Dim Off',
    },
  },
}
