return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	config = function()
		require("noice").setup({
			presets = { command_palette = true },
			lsp = { signature = { auto_open = { enabled = false } } },
			views = { mini = { timeout = 2000, reverse = false } },
			routes = {
				{
					filter = { event = "lsp", kind = "progress" },
					opts = { skip = true },
				},
			},
		})

		vim.keymap.set("n", "<leader>zl", "<cmd>Noice<cr>", { desc = "List messages" })
		vim.keymap.set("n", "<leader>zc", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss messages" })
	end,
}
