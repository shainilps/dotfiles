return {
	"tpope/vim-fugitive",
	dependencies = { "tpope/vim-rhubarb" },
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "fugitive window" })
		vim.keymap.set({ "n", "v" }, "<leader>gl", ":G log<CR>", { desc = "git logs" })
		vim.keymap.set({ "n", "v" }, "<leader>go", ":GBrowse<CR>", { desc = "open in browser" })
		vim.keymap.set({ "n", "v" }, "<leader>gb", ":G blame<CR>", { desc = "git blame" })
	end,
}
