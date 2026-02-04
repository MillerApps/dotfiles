--------------------------------------------------------------------------------
-- LSP Configuration & Plugins
--------------------------------------------------------------------------------
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      -- Automatically install LSPs and related tools
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Active fork of Mason tool installer:
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP (archived but still works if you like it)
      -- Alternative: https://github.com/folke/noice.nvim or other UI plugins
      { 'j-hui/fidget.nvim', opts = {} },

      -- Improved support for setting up Lua development in Neovim configs
      { 'folke/lazydev.nvim', ft = 'lua', opts = {} },
    },
    config = function()
      ----------------------------------------------------------------------------
      --  Setup LSP-on-attach Keymappings
      ----------------------------------------------------------------------------
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Highlight references when cursor hovers on a symbol
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      ----------------------------------------------------------------------------
      --  Extend LSP Capabilities (Autocompletion, Snippets, etc.)
      ----------------------------------------------------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Set default capabilities for all servers
      vim.lsp.config('*', { capabilities = capabilities })

      ----------------------------------------------------------------------------
      --  Servers to Enable / Configure
      ----------------------------------------------------------------------------
      -- Mason-managed servers are auto-enabled by mason-lspconfig.
      -- External servers are enabled manually below.
      local servers = {
        rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
        -- SourceKit (Swift) — installed via Xcode, not Mason
        sourcekit = {
          cmd = { '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp' },
        },
        -- Nix LSP — installed via nix, not Mason
        nil_ls = {
          cmd = { 'nil' },
          settings = {
            ['nil'] = {
              formatting = {
                command = { 'alejandra' },
              },
              nix = {
                flake = {
                  autoEvalInputs = true,
                },
              },
            },
          },
        },
      }

      local external_servers = { 'sourcekit', 'nil_ls' }

      -- Apply per-server config via vim.lsp.config (merges with lsp/ defaults)
      for name, config in pairs(servers) do
        vim.lsp.config(name, config)
      end

      ----------------------------------------------------------------------------
      --  Mason Setup
      ----------------------------------------------------------------------------
      require('mason').setup()

      require('mason-tool-installer').setup {
        ensure_installed = {
          'rust-analyzer',
          'lua-language-server',
          'stylua',
          'gopls',
          'bash-language-server',
          'markdown-oxide',
        },
        auto_update = false,
        run_on_start = true,
      }

      -- mason-lspconfig installs servers; automatic_enable (default: true)
      -- calls vim.lsp.enable() for each installed mason server.
      require('mason-lspconfig').setup {
        ensure_installed = { 'rust_analyzer', 'lua_ls' },
      }

      -- Enable servers installed outside of Mason
      for _, name in ipairs(external_servers) do
        vim.lsp.enable(name)
      end
    end,
  },
}
