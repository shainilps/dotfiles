return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>", { noremap = true, silent = true })
	end,
}

-- have some benefit when seeing big project struture
