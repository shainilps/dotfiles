return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- seriously this typescriptecosystem is such a pain with linters
		local function has_eslint_config()
			local configs = {
				-- "eslint.config.mjs",
				-- ".eslint.config.cjs",
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
	end,
}
