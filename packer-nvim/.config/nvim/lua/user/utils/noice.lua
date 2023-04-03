local noice_status_ok, noice = pcall(require, "noice")
if not noice_status_ok then
	print("Unable to load: noice")
  return
end

local notify_status_ok, notify = pcall(require, "notify")
if not notify_status_ok then
	print("Unable to load: notify")
  return
end

notify.setup({
	background_colour = "#000000",
})

noice.setup({
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "search_count",
			},
			opts = { skip = true },
		},
	},
	cmdline = {
    format = {
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = " 󰶹", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " 󰶼", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
      input = {}, -- Used by input()
      -- lua = false, -- to disable a format, set to `false`
    },
	},
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
})

