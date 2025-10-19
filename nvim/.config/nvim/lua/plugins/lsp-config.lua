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
					"tailwindcss",
					"dockerls",
					"docker_compose_language_service",
					-- "prismals",
					"bashls",
					-- "elmls",
					"emmet_ls",
					-- "rust_analyzer", --using rustup one
					"nil_ls", -- nix
					"zls",
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
					-- "fourmolu",
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				"gopls",
				"lua_ls",
				"clangd",
				"rust_analyzer",
				"ts_ls",
				"cssls",
				"htmls",
				"tailwindcss",
				"docker_compose_language_service",
				"dockerls",
				"elixirls",
				"bashls",
				"elmls",
				"ocamllsp",
				"hls",
				"nil_ls",
				"zls",
			}
			for _, server in ipairs(servers) do
				vim.lsp.config[server] = {
					capabilities = capabilities,
				}
			end

			vim.lsp.enable(servers)

			-- lspconfig.emmet_ls.setup({
			-- 	capabilities = capabilities,
			-- 	filetypes = {
			-- 		"html",
			-- 		"typescriptreact",
			-- 		"javascriptreact",
			-- 		"css",
			-- 		"sass",
			-- 		"scss",
			-- 		"less",
			-- 		"svelte",
			-- 	},
			-- })

			-- lsp settings
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
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
