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
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				lua = { "stylua" },
				go = { "gofmt", "goimports" },
				bash = { "shfmt" },
				-- elm = { "elm-format" },
				rust = { "rustfmt" },
				haskell = { "fourmolu" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				ocaml = { "ocamlformat" },
				-- nix = { "nixfmt" },
				zig = { "zigfmt" },
			},

			formatters = {
				["clang-format"] = {
					command = "clang-format",
					-- ColumnLimit: 100
					args = '--style="{BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}"',
				},
				["ocamlformat"] = {
					command = "ocamlformat",
					-- stdin = true,
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
		end)
	end,
}
