return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "lua", "c", "cpp", "css", "typescript", "javascript" ,"go","markdown", "html" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
