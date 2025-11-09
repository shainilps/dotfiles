return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local function map(lhs, rhs, opts)
			vim.keymap.set("n", lhs, rhs, opts or {})
		end

		map("<leader>a", function() -- Add file to Harpoon
			harpoon:list():add()
		end, { desc = "Add file to Harpoon" })

		map("<leader>h", function() -- Toggle quick menu
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon menu" })

		map("<leader>1", function() -- Jump to file 1
			harpoon:list():select(1)
		end, { desc = "Harpoon file 1" })

		map("<leader>2", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon file 2" })

		map("<leader>3", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon file 3" })

		map("<leader>4", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon file 4" })

		map("<leader>5", function()
			harpoon:list():select(5)
		end, { desc = "Harpoon file 5" })
	end,
}
