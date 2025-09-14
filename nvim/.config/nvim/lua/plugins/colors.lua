-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine",
-- 	config = function()
-- 		require("rose-pine").setup({
-- 			variant = "main", -- auto, main, moon, or dawn
-- 			dark_variant = "main", -- main, moon, or dawn
-- 			dim_inactive_windows = true,
-- 			extend_background_behind_borders = true,
--
-- 			enable = {
-- 				terminal = true,
-- 				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
-- 				migrations = true, -- Handle deprecated options automatically
-- 			},
--
-- 			styles = {
-- 				bold = true,
-- 				italic = true,
-- 				transparency = false,
-- 			},
--
-- 			groups = {
-- 				border = "muted",
-- 				link = "iris",
-- 				panel = "surface",
--
-- 				error = "love",
-- 				hint = "iris",
-- 				info = "foam",
-- 				note = "pine",
-- 				todo = "rose",
-- 				warn = "gold",
--
-- 				git_add = "foam",
-- 				git_change = "rose",
-- 				git_delete = "love",
-- 				git_dirty = "rose",
-- 				git_ignore = "muted",
-- 				git_merge = "iris",
-- 				git_rename = "pine",
-- 				git_stage = "iris",
-- 				git_text = "rose",
-- 				git_untracked = "subtle",
--
-- 				h1 = "iris",
-- 				h2 = "foam",
-- 				h3 = "rose",
-- 				h4 = "gold",
-- 				h5 = "pine",
-- 				h6 = "foam",
-- 			},
--
-- 			palette = {
-- 				-- Override the builtin palette per variant
-- 				-- moon = {
-- 				--     base = '#18191a',
-- 				--     overlay = '#363738',
-- 				-- },
-- 			},
--
-- 			-- NOTE: Highlight groups are extended (merged) by default. Disable this
-- 			-- per group via `inherit = false`
-- 			highlight_groups = {
-- 				-- Comment = { fg = "foam" },
-- 				-- StatusLine = { fg = "love", bg = "love", blend = 15 },
-- 				-- VertSplit = { fg = "muted", bg = "muted" },
-- 				-- Visual = { fg = "base", bg = "text", inherit = false },
-- 			},
--
-- 			before_highlight = function(group, highlight, palette)
-- 				-- Disable all undercurls
-- 				-- if highlight.undercurl then
-- 				--     highlight.undercurl = false
-- 				-- end
-- 				--
-- 				-- Change palette colour
-- 				-- if highlight.fg == palette.pine then
-- 				--     highlight.fg = palette.foam
-- 				-- end
-- 			end,
-- 		})
--
-- 		vim.cmd("colorscheme rose-pine")
-- 		-- vim.cmd("colorscheme rose-pine-main")
-- 		-- vim.cmd("colorscheme rose-pine-moon")
-- 		-- vim.cmd("colorscheme rose-pine-dawn")
-- 	end,
-- }

-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		require("kanagawa").setup({
-- 			compile = false, -- enable compiling the colorscheme
-- 			undercurl = true, -- enable undercurls
-- 			commentStyle = { italic = true },
-- 			functionStyle = {},
-- 			keywordStyle = { italic = true },
-- 			statementStyle = { bold = true },
-- 			typeStyle = {},
-- 			transparent = false, -- do not set background color
-- 			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
-- 			terminalColors = true, -- define vim.g.terminal_color_{0,17}
-- 			theme = "dragon", -- Load "wave" theme
-- 			background = { -- map the value of 'background' option to a theme
-- 				dark = "dragon", -- try "dragon" !
-- 				-- light = "lotus",
-- 			},
-- 			overrides = function()
-- 				return {
-- 					["@markup.link.label.tsx"] = { underline = false },
-- 				}
-- 			end,
-- 		})
-- 		vim.cmd("colorscheme kanagawa")
-- 	end,
-- }

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			-- transparent_background = true,
			style = {
				comments = { "italic" },
				strings = { "italic" },
				operators = { "italic" },
			},
			default_integrations = true,
			integrations = {
				cmp = true,
				treesitter = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

-- return {
--   "gbprod/nord.nvim",
--   name = "nord",
--   priority = 1000,
--   config = function()
--     require("nord").setup({
--       styles = {
--         comments = { italic = true },
--         strings = { italic = true },
--         operators = { italic = true }
--       },
--       transparent = true,
--       errors = { mode = "bg" }
--     })
--     vim.cmd.colorscheme("nord")
--   end,
-- }
--

--
-- return {
--   "ellisonleao/gruvbox.nvim",
--   name = "gruvbox",
--   priority = 1000,
--   config = function()
--     require("gruvbox").setup({
--       transparent_mode = true,
--       italic = {
--         strings = true,
--         emphasis = true,
--         comments = true,
--         operators = false,
--         -- folds = true,
--       },
--     })
--     vim.o.background = "dark"
--     vim.cmd.colorscheme("gruvbox")
--   end,
-- }
--

--  return {
--   "EdenEast/nightfox.nvim",
--   name = "nightfox",
--   priority = 1000,
--   config = function()
--     require("nightfox").setup({
--       transparent = true,
--     })
--     vim.cmd.colorscheme("duskfox")
--   end,
-- }
