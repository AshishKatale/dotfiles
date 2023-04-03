local handlers_status_ok, handlers = pcall(require, "user.plugins.lsp.handlers")
if not handlers_status_ok then
	print("Unable to load: user.plugins.lsp.handlers")
	return
end

local lsp_settings = {
	["lua_ls"] = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		}
	},
	["rust_analyzer"] = {
		cmd = {"rustup", "run", "stable", "rust-analyzer"},
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
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
	}
}

return lsp_settings
