return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  opts = {
    -- disable ui in favor of render-markdown.nvim
    ui = { enable = false },
    legacy_commands = false,
    workspaces = {
      {
        name = 'Dev',
        path = '/Users/tylermiller/Library/Mobile Documents/iCloud~md~obsidian/Documents/Dev/',
      },
    },
    -- completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = false,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = 'telescope.nvim',
    },
    frontmatter = {
      func = function(note)
        local out = {
          created = os.date '!%Y-%m-%d %H:%M:%S',
          title = note.id,
          aliases = note.aliases,
          tags = note.tags,
        }
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
    },
  },
  keys = {
    { '<leader>of', ':Obsidian search<CR>', desc = 'Search files' },
    { '<leader>os', ':Obsidian quick-switch<CR>', desc = 'Quick switch' },
    { '<leader>on', ':Obsidian new<CR>', desc = 'New note' },
    { '<leader>ol', ':Obsidian follow-link<CR>', desc = 'Follow link' },
    { '<leader>ob', ':Obsidian backlinks<CR>', desc = 'Show backlinks' },
    { '<leader>ot', ':Obsidian tags<CR>', desc = 'Browse tags' },
  },
}
