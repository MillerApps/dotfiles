return {
  {
    -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
    config = function()
      require('Comment').setup() -- Needed to set default mappings
    end,
  },
}
