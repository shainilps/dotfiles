return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				"gopls",
				"lua_ls",
				"clangd",
				"rust_analyzer",
				"ts_ls",
				"tailwindcss",
				"elixirls",
				"bashls",
				"nil_ls",
				"zls",
				"ocamllsp",
				"solidity_ls_nomicfoundation",
                "clojure_lsp",
                "hls"
			}
			for _, server in ipairs(servers) do
				vim.lsp.config[server] = {
					capabilities = capabilities,
				}
			end

			vim.lsp.enable(servers)

			-- lsp settings
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			vim.keymap.set("n", "D", function()
				vim.diagnostic.open_float(nil, {
					border = "rounded",
					source = "always",
					focusable = false,
				})
			end, { noremap = true, desc = "show diagnostic under cursor" })
		end,
	},
}
