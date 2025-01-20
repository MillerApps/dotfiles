return {
  {
    'github/copilot.vim',
    config = function()
      -- Control + J to accept completion
      vim.cmd [[imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")]]
      vim.g.copilot_no_tab_map = true
    end,
  },
}
