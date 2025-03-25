return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'leoluz/nvim-dap-go',
    'rcarriga/nvim-dap-ui',
    'jay-babu/mason-nvim-dap.nvim',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    require('dapui').setup()
    require('dap-go').setup()
    require('mason-nvim-dap').setup {
      ensure_installed = { 'python', 'delve' },
    }
    local dap, dapui = require 'dap', require 'dapui'

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', '<Leader>bt', ':DapToggleBreakpoint<CR>')
    vim.keymap.set('n', '<Leader>bc', ':DapContinue<CR>')
    vim.keymap.set('n', '<Leader>bx', ':DapTerminate<CR>')
    vim.keymap.set('n', '<Leader>bo', ':DapStepOver<CR>')
  end,
}
