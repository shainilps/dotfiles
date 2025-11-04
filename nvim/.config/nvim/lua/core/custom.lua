vim.api.nvim_create_user_command("GoAddTags", function(opts)
	local tag = opts.args ~= "" and opts.args or "json"
	local file = vim.fn.expand("%:p")

	local line_start = opts.line1
	local line_end = opts.line2

	local cmd = string.format(
		"gomodifytags -file %s -line %d,%d -add-tags %s -add-options %s=omitempty -w",
		vim.fn.shellescape(file),
		line_start,
		line_end,
		tag,
		tag
	)

	vim.fn.system(cmd)
	vim.cmd("edit!")
end, {
	nargs = "?",
	range = true,
})

vim.keymap.set("v", "<leader>tj", ":GoAddTags json<CR>", { desc = "Add json tags" })
