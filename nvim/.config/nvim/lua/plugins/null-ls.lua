-- this uses none ls plugin
return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports,
				-- null_ls.builtins.formatting.goimports_reviser,
				null_ls.builtins.formatting.golines,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.code_actions.gomodifytags,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.clang_format,
				-- null_ls.builtins.formatting.sql_formatter,
				null_ls.builtins.diagnostics.golangci_lint,
				require("none-ls.diagnostics.eslint_d").with({
					condition = function(utils)
						-- Use eslint_d only if an ESLint configuration file is present in the project
						return utils.root_has_file(".eslintrc.js")
							or utils.root_has_file(".eslintrc.json")
							or utils.root_has_file(".eslintrc.yaml")
					end,
				}),
			},
			debug = true,
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { noremap = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
}
