return {
	"echasnovski/mini.diff",
	version = false,
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	config = function()
		local diff = require("mini.diff")

		diff.setup({
			-- jj first, git as fallback. mini.diff tries each in order and moves on
			-- whenever a source's `attach` returns false, so a jj repo uses jj and
			-- everything else keeps using git.
			source = {
				require("core.jj-diff").source,
				diff.gen_source.git(),
			},
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
