return {
	-- mason
	{
		"mason-org/mason.nvim",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")

			require("mason").setup()

			mason_lspconfig.setup({
				automatic_enable = false,
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"clangd",
					-- "svelte",
					-- "astro",
					"cssls",
					"html",
					"sqls",
					"tailwindcss",
					"dockerls",
					"docker_compose_language_service",
					"prismals",
					"bashls",
					-- "elmls",
					"emmet_ls",
					-- "rust_analyzer", --using rustup one
					"nil_ls", -- nix
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier",
					"stylua",
					"clangd",
					-- "elm-format",
					"goimports",
					"prettierd",
					"shfmt",
					"stylua",
					"eslint_d",
					"fourmolu",
					"sqlfmt",
					-- { 'eslint_d', version = '13.1.2' },
				},
			})
		end,
	},

	-- nvim lsp
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				},
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
			lspconfig.prismals.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			-- lspconfig.elmls.setup({ capabilities = capabilities })
			lspconfig.nil_ls.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({ capabilities = capabilities, cmd = { "rust-analyzer" } })

			lspconfig.ocamllsp.setup({ -- not installed through mason
				capabilities = capabilities,
				cmd = { "ocamllsp" },
			})

			lspconfig.hls.setup({ capabilities = capabilities }) -- nix shell

			-- lspconfig.hls.setup({
			-- 	capabilities = capabilities,
			-- 	args = { "--lsp" },
			-- 	cmd = { "haskell-language-server-wrapper" }, -- not installed through mason (nix)
			-- 	root_dir = lspconfig.util.root_pattern("*.cabal", "stack.yaml", "cabal.project", ".git", "*.hs"),
			-- 	filetypes = { "haskell", "lhaskell" },
			-- 	single_file_support = true,
			-- })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.diagnostic.config({
				virtual_text = false, -- no inline text
				signs = true, -- signs in the gutter
				underline = true, -- underline issues
				update_in_insert = false, -- don’t show while typing
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
