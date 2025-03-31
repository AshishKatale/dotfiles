return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    cmd = { 'DapContinue', 'DapToggleBreakpoint' },
    dependencies = {
      'nvim-neotest/nvim-nio',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'julianolf/nvim-dap-lldb',
      'leoluz/nvim-dap-go',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      local dap_virt_text = require('nvim-dap-virtual-text')
      local which_key = require('which-key')

      dap_virt_text.setup({ enabled = false })
      dapui.setup({
        controls = { enabled = false }, -- hide mouse controls
        floating = {
          max_width = 100,
          border = 'rounded'
        }
      })

      require('dap-go').setup()
      require('dap-lldb').setup()

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      vim.fn.sign_define('DapBreakpoint', { text = '󰄯', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '󰘪', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DapStopped', { text = '󰳟', texthl = 'GitsignsAdd' })
      vim.fn.sign_define('DapLogPoint', { text = '󰄯', texthl = 'DiagnosticSignHint' })

      which_key.add({
        -- already added in which_key.lua
        -- { '<leader>d',  group = 'Debug' },
        -- { '<leader>dd', '<cmd>DapContinue<cr>',         desc = 'DAP Continue' },
        -- { '<leader>db', '<cmd>DapToggleBreakpoint<cr>', desc = 'Breakpoint' },

        { '<leader>dD', dap.disconnect,        desc = 'Disconnect' },
        { '<leader>dc', dap.continue,          desc = 'Continue' },
        { '<leader>dC', dap.run_to_cursor,     desc = 'Run to Cursor' },
        { '<leader>di', dap.step_into,         desc = 'Step Into' },
        { '<leader>dn', dap.step_over,         desc = 'Step Over' },
        { '<leader>do', dap.step_out,          desc = 'Step Out' },
        { '<leader>dp', dap.step_back,         desc = 'Step Back' },
        { '<leader>dP', dap.pause,             desc = 'Pause' },
        { '<leader>dr', dap.restart,           desc = 'Restart' },
        { '<leader>dh', dap_virt_text.toggle,  desc = 'Toggle virtual text' },
        { '<leader>du', dapui.toggle,          desc = 'Toggle DAP UI' },
        { '<leader>dx', dap.clear_breakpoints, desc = 'Clear Breakpoints' },
        {
          '<leader>dk',
          function() dapui.eval(nil, { enter = true }) end,
          desc = 'Eval var under cursor'
        },
        {
          '<leader>dK',
          function() dapui.eval(nil, { enter = true }) end,
          desc = 'Eval var under cursor'
        },
      })
    end,
  },
}
