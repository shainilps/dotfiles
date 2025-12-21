return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"json",
					"yaml",
					"lua",
					"rust",
					"c",
					"cpp",
					"rust",
					"elixir",
					"javascript",
					"typescript",
					"go",
					"zig",
                    "haskell",
                    "clojure",
                    "scala"
				},
				highlight = { enable = true },
				indent = { enable = true },
				modules = {},
				auto_install = false,
				sync_install = false,
				ignore_install = {},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				multiwindow = false,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
		end,
	},
}
