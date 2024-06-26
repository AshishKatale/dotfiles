local which_key_status_ok, which_key = pcall(require, "which-key")
if not which_key_status_ok then
  vim.notify("Unable to load: whichkey")
  return
end
local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  vim.notify("Unable to load: cmp_nvim_lsp")
  return
end

local lsp_highlight_document = function(client)
  local augroup = vim.api.nvim_create_augroup("lspcursor", { clear = true })
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorMoved" }, {
      callback = function(ev)
        if ev.event == "CursorHold" then
          vim.lsp.buf.document_highlight()
          vim.diagnostic.open_float({ max_width = 80 })
        else
          vim.lsp.buf.clear_references()
        end
      end,
      group = augroup
    })
  else
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      callback = function() vim.diagnostic.open_float({ max_width = 80 }) end,
      group = augroup
    })
  end
end

function RangeFormat()
  vim.lsp.buf.format({
    async = true,
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    }
  })
end

local lsp_keymaps = function(bufnr)
  local opts = {
    mode = "n",     -- NORMAL mode
    prefix = "g",
    buffer = bufnr, -- Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  local mappings = {
    name = "Go to",
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
    I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    r = { "<cmd>Trouble lsp_references<CR>", "References trouble" },
    R = { "<cmd>Telescope lsp_references<CR>", "References telescope" },
    s = { "<cmd>Telescope lsp_document_symbols<CR>", "File symbols" },
    S = { "<cmd>Telescope lsp_workspace_symbols<CR>", "Workspace symbols" },
    b = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Pervious diagnostic" },
    n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
  }

  local leader_mappings = {
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "LSP rename" },
    c = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "LSP Code action" },
    f = {
      "<cmd>lua vim.lsp.buf.format({ timeout_ms = 10000 })<CR>",
      "Format Document"
    },
  }

  local leader_opts = {}
  for k, v in pairs(opts) do
    leader_opts[k] = v;
  end
  leader_opts.prefix = "<leader>"

  vim.api.nvim_buf_set_keymap(
    0, "v", "<leader>f",
    "<cmd>lua RangeFormat()<CR><esc>",
    { noremap = true, silent = true, nowait = true }
  )

  which_key.register(mappings, opts)
  which_key.register(leader_mappings, leader_opts)
end

local M = {}
M.capabilities = cmp_nvim_lsp.default_capabilities()
M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

M.lsp_settings = {
  ["lua_ls"] = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
      Lua = {
        runtime = { version = "Lua 5.1" },
        diagnostics = {
          globals = { "vim" },
        },
      },
    }
  },
  ["rust_analyzer"] = {
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  },
  ["gopls"] = {
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  ["tailwindcss"] = {
    autostart = false
  }
}

return M
