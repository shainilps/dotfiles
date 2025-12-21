return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			keymaps = {
				["<C-l>"] = false,
				["<C-h>"] = false,
			},
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
		})
		vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
