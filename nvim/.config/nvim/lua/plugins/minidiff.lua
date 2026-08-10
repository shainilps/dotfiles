return {
	"echasnovski/mini.diff",
	version = false,
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	config = function()
		local diff = require("mini.diff")

		diff.setup({
			view = {
				style = "sign",
				signs = { add = "▕", change = "▕", delete = "▕" },
			},
			mappings = {
				apply = "",
				reset = "gH",
				textobject = "ih",
				goto_first = "[H",
				goto_prev = "[h",
				goto_next = "]h",
				goto_last = "]H",
			},
		})

		vim.keymap.set("n", "<leader>hr", "gHih", { remap = true, desc = "Reset hunk" })
		vim.keymap.set("x", "<leader>hr", "gH", { remap = true, desc = "Reset hunk" })
		vim.keymap.set("n", "<leader>hp", function()
			diff.toggle_overlay(0)
		end, { desc = "Preview hunk (overlay)" })
		vim.keymap.set("n", "<leader>gR", function()
			diff.do_hunks(0, "reset")
		end, { desc = "Reset buffer" })
	end,
}
