local status_ok, focus = pcall(require, "focus")
if not status_ok then
	print("Unable to load: focus.nvim")
  return
end

focus.setup({
	signcolumn = false,
	treewidth = 30,
	winhighlight = true,
	absolutenumber_unfocussed = true,
	hybridnumber = true,
	colorcolumn = {enable = false, width = 82}
})
