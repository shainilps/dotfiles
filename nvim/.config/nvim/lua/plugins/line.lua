return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = "|",
				section_separators = { left = "", right = "" },
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return string.format("%7s", str)
						end,
					},
				},
				lualine_b = {
					{
						"diagnostics",
						sources = {
							function()
								local sev = vim.diagnostic.severity
								local function ws(severity)
									return vim.tbl_count(vim.diagnostic.get(nil, { severity = severity }))
								end
								return {
									error = ws(sev.ERROR),
									warn = ws(sev.WARN),
									info = ws(sev.INFO),
									hint = ws(sev.HINT),
								}
							end,
						},
						sections = { "error", "warn" },
						symbols = { error = "󰅚 ", warn = " " },
						always_visible = false,
					},
				},
				lualine_c = {
					{
						"filetype",
						colored = true,
						icon_only = true,
						separator = "",
						padding = { left = 1, right = 0 },
					},
					{
						"filename",
						separator = ">",
						path = 0,
						symbols = { modified = "*", readonly = "[-]", unnamed = "[No Name]" },
					},
				},
				lualine_x = {
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return require("noice").api.status.mode.has()
						end,
						color = { fg = "#ff9e64" },
					},
					"fileformat",
				},
				lualine_y = { "branch", "progress" },
				lualine_z = { "location" },
			},
			extensions = { "quickfix", "oil" },
		})
		vim.opt.showmode = false
	end,
}
