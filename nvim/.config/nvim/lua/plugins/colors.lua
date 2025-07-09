return {
	"rebelot/kanagawa.nvim",
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
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			theme = "dragon", -- Load "wave" theme
			background = { -- map the value of 'background' option to a theme
				dark = "dragon", -- try "dragon" !
				-- light = "lotus",
			},
			overrides = function()
				return {
					["@markup.link.label.tsx"] = { underline = false },
				}
			end,
		})
		vim.cmd("colorscheme kanagawa")
	end,
}

-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   config = function()
--     require("catppuccin").setup({
--       flavour = "frappe",
--       transparent_background = true,
--       style = {
--         comments = { "italic" },
--         strings = { "italic" },
--         operators = { "italic" },
--       },
--       default_integrations = true,
--       integrations = {
--         cmp = true,
--         treesitter = true
--       },
--     })
--     vim.cmd.colorscheme("catppuccin")
--   end,
-- }
--
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

-- return {
--   "tanvirtin/monokai.nvim",
--   name = "monokai",
--   priority = 1000,
--   config = function()
--     require('monokai').setup {
--       palette = require('monokai'),
--       transparent=true
--       -- italics = false
--     }
--     -- vim.cmd.colorscheme("monokai")
--   end,
-- }
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
