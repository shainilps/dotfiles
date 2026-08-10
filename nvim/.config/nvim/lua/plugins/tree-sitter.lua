return {
	-- ancient at this point lol
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	build = ":TSUpdate",
	-- 	branch = "master",
	-- 	config = function()
	-- 		local configs = require("nvim-treesitter.configs")
	-- 		configs.setup({
	-- 			ensure_installed = {
	-- 				"json",
	-- 				"yaml",
	-- 				"lua",
	-- 				"rust",
	-- 				"asm",
	-- 				"c",
	-- 				"cpp",
	-- 				"rust",
	-- 				"elixir",
	-- 				-- "javascript",
	-- 				"typescript",
	-- 				"go",
	-- 				-- "zig",
	-- 				"haskell",
	-- 				-- "clojure",
	-- 				-- "scala"
	-- 			},
	-- 			highlight = { enable = true },
	-- 			indent = { enable = true },
	-- 			modules = {},
	-- 			auto_install = false,
	-- 			sync_install = false,
	-- 			ignore_install = {},
	-- 		})
	-- 	end,
	-- },

	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ensure_installed = {
				"json",
				"yaml",
				"lua",
				"rust",
				"asm",
				"c",
				"cpp",
				"rust",
				"elixir",
				-- "javascript",
				"typescript",
				"go",
				-- "zig",
				"haskell",
				-- "clojure",
				-- "scala"
			}

			local function contains(list, value)
				for _, v in ipairs(list) do
					if v == value then
						return true
					end
				end
				return false
			end

			local already_installed = require("nvim-treesitter").get_installed()

			local needs_to_install = {}
			for _, v in ipairs(ensure_installed) do
				if not contains(already_installed, v) then
					table.insert(needs_to_install, v)
				end
			end

			if #needs_to_install ~= 0 then
				require("nvim-treesitter").install(needs_to_install)
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
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
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")

			local function map_obj(key, obj)
				vim.keymap.set({ "x", "o" }, key, function()
					select.select_textobject(obj, "textobjects")
				end, { desc = "Select " .. obj })
			end

			map_obj("af", "@function.outer")
			map_obj("if", "@function.inner")
			map_obj("ac", "@class.outer")
			map_obj("ic", "@class.inner")
			map_obj("aa", "@parameter.outer")
			map_obj("ia", "@parameter.inner")
		end,
	},
}
