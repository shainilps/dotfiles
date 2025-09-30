return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				svelte = { "prettierd" },
				astro = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				-- graphql = { "prettierd" },
				-- liquid = { "prettierd" },
				lua = { "stylua" },
				go = { "gofmt", "goimports" },
				bash = { "shfmt" },
				-- elm = { "elm-format" },
				rust = { "rustfmt" },
				haskell = { "fourmolu" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				ocaml = { "ocp-indent" },
				nix = { "nixfmt" },
				zig = { "zigfmt" },
			},

			formatters = {
				["clang-format"] = {
					command = "clang-format", -- optional override
					args = '--style="{BasedOnStyle: google, IndentWidth: 4, TabWidth: 4, UseTab: Never, ColumnLimit: 100}"',
				},
				["ocp-indent"] = {
					command = "ocp-indent",
					stdin = true,
				},
				["rustfmt"] = {
					command = "rustfmt",
				},
				["gofmt"] = {
					command = "gofmt",
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
