return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require("lualine").setup({
      options = {
        -- theme = "dracula"
            -- theme = 'nord'
            theme = 'kanagawa'
      }
    })
  end
}

