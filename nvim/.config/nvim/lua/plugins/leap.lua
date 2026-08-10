return {
	"https://codeberg.org/andyg/leap.nvim",
	event = "VeryLazy",

	config = function()
		vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-forward)", {
			desc = "Leap forward",
		})

		vim.keymap.set({ "n", "x", "o" }, "gS", "<Plug>(leap-backward)", {
			desc = "Leap backward",
		})

		vim.keymap.set({ "n", "x", "o" }, "gm", "<Plug>(leap-from-window)", {
			desc = "Leap from window",
		})
	end,
}
