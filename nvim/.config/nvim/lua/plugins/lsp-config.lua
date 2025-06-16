return {
	-- mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- mason config
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					-- "gopls",
					"clangd",
					"svelte",
					"astro",
					"cssls",
					"html",
					"sqls",
					"tailwindcss",
					"dockerls",
					"docker_compose_language_service",
					"rust_analyzer",
					"prismals",
					"bashls",
					"elmls",
				},
			})
		end,
	},
	--
	-- {
	--
	-- 	vim.lsp.config("lua_ls", {}),
	-- 	vim.lsp.config("ts_ls", {}),
	-- 	vim.lsp.config("gopls", {}),
	-- 	vim.lsp.config("clangd", {}),
	-- 	vim.lsp.config("svelte", {}),
	-- 	vim.lsp.config("astro", {}),
	-- 	vim.lsp.config("cssls", {}),
	-- 	vim.lsp.config("html", {}),
	-- 	vim.lsp.config("sqls", {}),
	-- 	vim.lsp.config("tailwindcss", {}),
	-- 	vim.lsp.config("dockerls", {}),
	-- 	vim.lsp.config("docker_compose_language_service", {}),
	-- 	vim.lsp.config("rust_analyzer", {}),
	-- 	vim.lsp.config("ruff", {}),
	-- 	vim.lsp.config("prismals", {}),
	-- 	vim.lsp.config("bashls", {}),
	-- 	vim.lsp.config("elmls", {}),
	-- 	vim.keymap.set("n", "K", vim.lsp.buf.hover, {}),
	-- 	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}),
	-- 	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {}),
	-- },

	-- nvim lsp
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			-- lspconfig.gopls.setup({
			-- 	capabilities = capabilities,
			-- })
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.svelte.setup({ capabilities = capabilities })
			lspconfig.astro.setup({ capabilities = capabilities })
			lspconfig.cssls.setup({ capabilities = capabilities })
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.sqls.setup({ capabilities = capabilities })
			lspconfig.tailwindcss.setup({ capabilities = capabilities })
			lspconfig.dockerls.setup({ capabilities = capabilities })
			lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
			lspconfig.elixirls.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({ capabilities = capabilities })
			lspconfig.prismals.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.elmls.setup({ capabilities = capabilities })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			-- vim.keymap.set("n", "K", vim.diagnostic.open_float, {})
			-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.diagnostic.config({
				virtual_text = false, -- No inline text
				signs = true, -- Signs in the gutter
				underline = true, -- Underline issues
				update_in_insert = false, -- Don’t show while typing
				severity_sort = true,
			})
			vim.keymap.set("n", "<leader>d", function()
				vim.diagnostic.open_float(nil, {
					border = "rounded",
					source = "always",
					focusable = false,
				})
			end, { desc = "Show diagnostic under cursor" })
		end,
	},
}
