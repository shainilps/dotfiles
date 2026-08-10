return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	config = function()
		require("noice").setup({
			presets = { command_palette = true },

			cmdline = {
				format = {
					filter = {
						pattern = "^:%s*!",
						icon = "$",
						title = " Shell ",
						lang = "shell",
					},
				},
			},

			lsp = { signature = { auto_open = { enabled = false } } },
			views = {
				mini = { timeout = 2000, reverse = false },
				shell_output = {
					backend = "split",
					position = "right",
					size = "40%",
					enter = true,
					close = {
						keys = { "q", "<Esc>" },
					},
					win_options = {
						winhighlight = "Normal:Normal",
					},
				},
			},
			routes = {
				{
					filter = { event = "lsp", kind = "progress" },
					opts = { skip = true },
				},
				{
					view = "shell_output",
					filter = {
						event = "msg_show",
						kind = {
							"shell_out",
							"shell_err",
						},
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>zl", "<cmd>Noice<cr>", { desc = "List messages" })
		vim.keymap.set("n", "<leader>zc", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss messages" })
	end,
}
