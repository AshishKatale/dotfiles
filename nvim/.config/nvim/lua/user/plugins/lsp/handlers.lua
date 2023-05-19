local which_key_status_ok, which_key = pcall(require, "which-key")
if not which_key_status_ok then
	print("Unable to load: whichkey")
	return
end
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	print("Unable to load: cmp_nvim_lsp")
	return
end

local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignInfo", text = "" },
		{ name = "DiagnosticSignHint", text = "󰌵" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignError", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client)
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorHold <buffer> lua vim.diagnostic.open_float()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
	else
		vim.cmd[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.diagnostic.open_float()
      augroup END
    ]]
	end
end

local function lsp_keymaps(bufnr)

	local opts = {
		mode = "n",   -- NORMAL mode
		prefix = "g",
		buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local mappings = {
		name = "Go to",
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
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
		f = { "<cmd>lua vim.lsp.buf.format({ timeout_ms = 10000 })<CR>", "Format Document" },
	}

	local leader_opts = {}
	for k, v in pairs(opts) do
		leader_opts[k] = v;
	end
	leader_opts.prefix = "<leader>"

	vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, nowait = true })
	which_key.register(mappings, opts)
	which_key.register(leader_mappings, leader_opts)

end

M.on_attach = function(client, bufnr)
	-- if client.name == "tsserver" then
	-- 	client.server_capabilities.document_formatting = false
	-- end
	-- if client.name == "html" then
	-- 	client.server_capabilities.document_formatting = false
	-- end
	-- if client.name == "rust_analyzer" then
	-- 	require("lsp-inlayhints").on_attach(client, bufnr)
	-- end
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
	-- lsp_buf_formatting(client)
end

M.capabilities = cmp_nvim_lsp.default_capabilities()

return M
