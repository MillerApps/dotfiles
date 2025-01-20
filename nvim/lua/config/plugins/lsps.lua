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
      { 'folke/neodev.nvim', opts = {} },
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

      ----------------------------------------------------------------------------
      --  Servers to Enable / Configure
      ----------------------------------------------------------------------------
      local servers = {
        -- Rust
        rust_analyzer = {},
        -- SourceKit (Swift)
        require('lspconfig').sourcekit.setup {
          cmd = { '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp' },
        },
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        -- Nix (requires `nixd` to be installed, done via nix-darwin in my case)
        -- this could be better, but something is not working somewhere for me
        -- when adding the options {} table to the setup call
        -- TODO: Revist later
        require('lspconfig').nixd.setup {
          cmd = { 'nixd' },
          settings = {
            nixd = {
              nixpkgs = {
                expr = 'import <nixpkgs> { }',
              },
              formatting = {
                command = { 'alejandra' },
              },
            },
          },
        },
      }

      ----------------------------------------------------------------------------
      --  Mason Setup
      ----------------------------------------------------------------------------
      require('mason').setup()

      -- Install the servers above (plus any extra tools you want)
      require('mason-tool-installer').setup {
        ensure_installed = {
          -- These names match the Mason package names, so adjust as needed:
          -- 'rust-analyzer', 'lua-language-server', etc.
          'rust-analyzer',
          'lua-language-server',
          'stylua', -- e.g. for Lua formatting
        },
        auto_update = false,
        run_on_start = true,
      }

      require('mason-lspconfig').setup {
        -- Make sure these server names match the table keys in `servers`
        ensure_installed = vim.tbl_keys(servers),

        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
