return {
	"michaelb/sniprun",
	branch = "master",
	build = "sh install.sh",
	config = function()
		require("sniprun").setup({
			display = { "VirtualLine" },
			live_display = { "VirtualTextOk" },
			show_no_output = { "Classic" },
			snipruncolors = {
				SniprunVirtualTextOk = { link = "Delimiter" },
				SniprunVirtualTextErr = { link = "Error" },
			},
			ansi_escape = true,
		})

		vim.keymap.set("v", "<leader>r", "<cmd>SnipRun<cr>", { desc = "Run selection" })
		vim.keymap.set("n", "<leader>r", "<Plug>SnipRunOperator", { desc = "Run motion" })
		vim.keymap.set("n", "<leader>rr", "<cmd>SnipRun<cr>", { desc = "Run line" })
		vim.keymap.set("n", "<leader>rc", function()
			require("sniprun.display").close_all()
		end, { desc = "Clear sniprun output" })
	end,
}
