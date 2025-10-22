return {
	{

		"rebelot/kanagawa.nvim",
		enabled = true,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false, -- do not set background color
				dimInactive = true, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				theme = "wave", -- Load "wave" theme
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
				overrides = function()
					return {
						["@markup.link.label.tsx"] = { underline = false },
					}
				end,
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd("colorscheme tokyonight-night")
		end,
	},
	{
		"vague2k/vague.nvim",
		enabled = false,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other plugins
		config = function()
			-- NOTE: you do not need to call setup if you don't want to.
			require("vague").setup({
				-- optional configuration here
			})
			vim.cmd("colorscheme vague")
		end,
	},
}
