local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	print("Unable to load: mason")
	return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	print("Unable to load: mason-lspconfig")
	return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	print("Unable to load: lspconfig")
	return
end

local nvimcmp_status_ok, _ = pcall(require, "user.lsp.nvimcmp")
if not nvimcmp_status_ok then
	print("Unable to load: user.lsp.nvimcmp")
	return
end

local handlers_status_ok, handlers = pcall(require, "user.lsp.handlers")
if not handlers_status_ok then
	print("Unable to load: user.lsp.handlers")
	return
end

local lsconfig_status_ok, lspsettings = pcall(require, "user.lsp.settingsls")
if not lsconfig_status_ok then
	print("Unable to load: user.lsp.settingsls")
	return
end

mason.setup()
mason_lspconfig.setup()
handlers.setup()

mason_lspconfig.setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function (server_name) -- default handler (optional)
		lspconfig[server_name].setup({
			on_attach = handlers.on_attach,
			capabilities = handlers.capabilities
		})
	end,

	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:

	["lua_ls"] = function (server_name)
		lspconfig[server_name].setup(lspsettings[server_name])
	end,

}

lspconfig.rust_analyzer.setup(lspsettings["rust_analyzer"])

