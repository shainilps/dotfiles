return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"lua",
				"rust",
				"c",
				"json",
				"yaml",
				"cpp",
				"css",
				"svelte",
        "rust",
				"typescript",
				"elixir",
				"javascript",
				"go",
				"markdown",
				"html",
				"php",
				"prisma",
				"elm",
				"python",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
