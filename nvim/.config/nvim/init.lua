vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"

local o = vim.o
o.termguicolors = true
o.hlsearch = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.breakindent = true
o.swapfile = false
o.backup = false
o.writebackup = false
o.undofile = true
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.ignorecase = true
o.smartcase = true
o.updatetime = 250
o.timeoutlen = 300
o.completeopt = "menuone,noselect"
o.splitbelow = true
o.splitright = true
o.autoread = true
o.autoindent = true
o.smartindent = true
o.smarttab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.wrap = false
o.hidden = true

vim.keymap.set("n", "<Leader>w", ":w<CR>")
vim.keymap.set("n", "<Leader>q", ":q<CR>")
vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "L", "$")
vim.keymap.set("n", "vv", "<C-W>v")
vim.keymap.set("n", "ss", "<C-W>s")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("v", "y", "y`]", { noremap = true })
vim.keymap.set("v", "p", "p`]", { noremap = true })
vim.keymap.set("n", "p", "p`]", { noremap = true })
vim.keymap.set("n", "<Leader>ch", ":nohlsearch<Bar>:echo<CR>", { noremap = true })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<M-j>", ":cnext<CR>")
vim.keymap.set("n", "<M-k>", ":cprev<CR>")
vim.keymap.set("v", "p", '"_dP')

--- load some custom things
require("custom")

-- plugins

local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind

	if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
		vim.system({ "make" }, { cwd = ev.data.path })
	end

	if name == "nvim-treesitter" and (kind == "update") then
		local function build_treesitter()
			if vim.fn.exists(":TSUpdate") == 2 then
				vim.cmd("TSUpdate")
				vim.notify("Tree-sitter parsers updated", vim.log.levels.INFO)
			else
				vim.defer_fn(build_treesitter, 100)
			end
		end

		build_treesitter()
	end
end

vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })

-- vim.pack.add({ { src = "https://github.com/rebelot/kanagawa.nvim", name = "A-kanagawa" } })
-- vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "A-catpuccin" } })
vim.pack.add({ { src = "https://github.com/folke/tokyonight.nvim", name = "A-tokyonight" } })
vim.pack.add({ { src = "https://github.com/vague-theme/vague.nvim", name = "A-vague" } })

vim.pack.add({ { src = "https://github.com/folke/lazydev.nvim" } })
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
})
vim.pack.add({
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
})
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})
vim.pack.add({ { src = "https://github.com/stevearc/oil.nvim" } })
vim.pack.add({ { src = "https://github.com/tpope/vim-fugitive" } })
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
})
vim.pack.add({ { src = "https://github.com/ThePrimeagen/harpoon" } })

-------------------------------- color scheme ------------------------------------------------

vim.cmd.colorscheme("tokyonight-night")

-------------------------------- lazydev (for lua) --------------------------------------------

require("lazydev").setup({
	library = {
		"lazy.nvim", -- include plugin as library
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } }, -- example extra
	},
})

-------------------------------------- tree sitter -------------------------------------------

local configs = require("nvim-treesitter.configs")
configs.setup({
	ensure_installed = {
		"json",
		"yaml",
		"lua",
		"rust",
		"c",
		"cpp",
		"rust",
		"typescript",
		"javascript",
		"go",
		"zig",
	},
	highlight = { enable = true },
	indent = { enable = true },
	auto_install = false,
	ignore_install = {},
	modules = {},
	sync_install = false,
})

require("treesitter-context").setup({
	enable = true,
	multiwindow = false,
	max_lines = 0,
	min_window_height = 0,
	line_numbers = true,
	multiline_threshold = 20,
	trim_scope = "outer",
	mode = "cursor",
	separator = nil,
	zindex = 20,
	on_attach = nil,
})

------------------------------------ mason (lsp and lsp) ----------------------------------------
require("mason").setup()

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

---------------------------------- completion ------------------------------------------

local ls = require("luasnip")
ls.add_snippets("go", require("snippets.go"))

local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	completion = {
		-- autocomplete = false, -- for turning off the auto-completion
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

---------------------------------------- formatters ------------------------------------
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
			command = "clang-format",
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
end)

----------------------------------------- linters ----------------------------------------------

local lint = require("lint")

local function has_eslint_config()
	configs = {
		".eslint.config.js",
		".eslintrc.yml",
		".eslintrc.js",
		".eslintrc.json",
	}

	for _, config in ipairs(configs) do
		local config_path = vim.fn.findfile(config, vim.fn.getcwd() .. "/")
		if config_path and config_path ~= "" then
			return true
		end
	end
	return false
end

lint.linters_by_ft = {
	javascript = has_eslint_config() and { "eslint_d" } or {},
	typescript = has_eslint_config() and { "eslint_d" } or {},
	javascriptreact = has_eslint_config() and { "eslint_d" } or {},
	typescriptreact = has_eslint_config() and { "eslint_d" } or {},
	svelte = has_eslint_config() and { "eslint_d" } or {},
	go = { "golangcilint" },
	bash = { "shellcheck" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

vim.keymap.set("n", "<leader>gl", function()
	lint.try_lint()
end)

------------------------------------------- oil -------------------------------------------------

require("oil").setup({
	keymaps = {
		["<C-l>"] = false,
		["<C-h>"] = false,
	},

	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

------------------------------------------ telscope -------------------------------------------

local telescope = require("telescope")

telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})

------------------------------------ harpoon -----------------------------------------------
local harpoon_ui = require("harpoon.ui")
local harppon_mark = require("harpoon.mark")

vim.keymap.set("n", "<leader>h", harpoon_ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>a", harppon_mark.add_file)
for i = 1, 5 do
	vim.keymap.set("n", "<leader>" .. i, function()
		harpoon_ui.nav_file(i)
	end, { noremap = true, silent = true })
end
