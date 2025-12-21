return {
	"ThePrimeagen/harpoon",
	config = function()
		local harpoon_ui = require("harpoon.ui")
		local harppon_mark = require("harpoon.mark")

		vim.keymap.set("n", "<leader>h", harpoon_ui.toggle_quick_menu)
		vim.keymap.set("n", "<leader>a", harppon_mark.add_file)
		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, function()
				harpoon_ui.nav_file(i)
			end, { noremap = true, silent = true })
		end
	end,
}
