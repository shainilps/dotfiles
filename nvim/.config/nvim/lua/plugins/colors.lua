return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      transparent_background = true,
      style = {
        comments = { "italic" },
        strings = { "italic" },
        operators = { "italic" },
      },
      default_integrations = true,
      integrations = {
        cmp = true,
        treesitter = true
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
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
