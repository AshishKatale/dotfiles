local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
	print("unable to load: dressing")
  return
end

dressing.setup({
	input = {
		relative = "editor",
		win_options = {
			-- Window transparency (0-100)
			winblend = 0,
			-- Disable line wrapping
			wrap = false,
		},
		mappings = {
			n = {
				["<Esc>"] = "Close",
				["<C-c>"] = "Close",
				["<CR>"] = "Confirm",
			},
			i = {
				["<C-c>"] = "Close",
				["<CR>"] = "Confirm",
				["<Up>"] = "HistoryPrev",
				["<Down>"] = "HistoryNext",
			},
		},
	}
})

