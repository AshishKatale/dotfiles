return function(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)
  local setCursor = function()
    vim.api.nvim_feedkeys(tostring(INPUT_LINE_NUMBER) .. 'ggzt', 'n', true)
    local line = vim.api.nvim_buf_line_count(0)
    if CURSOR_LINE <= line then
      line = CURSOR_LINE
    end
    vim.api.nvim_feedkeys(tostring(line - 1) .. 'j', 'n', true)
    vim.api.nvim_feedkeys('0', 'n', true)
    vim.api.nvim_feedkeys(tostring(CURSOR_COLUMN - 1) .. 'l', 'n', true)
  end

  local function show_floating_message()
    local message_lines = { ' SCROLLBACK   ' }
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, message_lines)

    local function open_msg_win()
      return vim.api.nvim_open_win(buf, false, {
        relative = 'editor',
        height = 1,
        width = vim.fn.strdisplaywidth(message_lines[1]),
        row = 0,
        col = vim.o.columns - 1,
        border = 'none',
      })
    end
    local win = open_msg_win()

    vim.api.nvim_set_hl(0, 'INDICATOR',
      { fg = '#000000', bg = '#F28B25', bold = true })

    local ns_id = vim.api.nvim_create_namespace('msg_highlights')
    vim.api.nvim_buf_set_extmark(buf, ns_id, 0, 0, {
      end_row = 1,
      end_col = 0,
      hl_group = 'INDICATOR'
    })

    local msg_visible = true
    vim.keymap.set('n', 'S',
      function()
        if msg_visible then
          msg_visible = false
          vim.api.nvim_win_close(win, false)
        else
          msg_visible = true
          win = open_msg_win()
        end
      end, { buffer = 0, silent = true })
  end

  vim.api.nvim_open_term(0, {})

  vim.keymap.set('n', '<Esc>', 'ZQ', { buffer = 0, silent = true })
  vim.keymap.set('n', 'q', 'ZQ', { buffer = 0, silent = true })
  vim.keymap.set('n', 'i', '<NOP>', { buffer = 0, silent = true })

  vim.opt.list = false
  vim.opt.showmode = true
  vim.opt.modified = false
  vim.opt.laststatus = 0
  vim.opt.showtabline = 0

  vim.cmd.stopinsert()
  vim.cmd.file('kitty_scrollback')
  show_floating_message()
  vim.defer_fn(setCursor, 10)
end
