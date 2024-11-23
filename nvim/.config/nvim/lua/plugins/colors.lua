-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		require("catppuccin").setup({
-- 			flavour = "mocha",
-- 			transparent_background = true,
-- 		})
-- 		vim.cmd.colorscheme("catppuccin")
-- 	end,
-- }
return {
  "gbprod/nord.nvim",
  name = "nord",
  priority = 1000,
  config = function()
    require("nord").setup({
      transparent = true,
    })
    vim.cmd.colorscheme("nord")
  end,
}
