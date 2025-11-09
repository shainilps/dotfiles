vim.api.nvim_create_user_command("GoAddTagsSmart", function(opts)
	local args = vim.split(opts.args, "%s+")
	local tag = args[1] ~= "" and args[1] or "json"
	local case_style = args[2] or "camel"

	local file = vim.fn.expand("%:p")
	local line_start = opts.line1
	local line_end = opts.line2

	local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)

	local function to_camel_case(name)
		name = name:gsub("^%s+", ""):gsub("%s+$", "")
		return name:sub(1, 1):lower() .. name:sub(2)
	end

	local function to_snake_case(name)
		-- remvoing trailing space
		name = name:gsub("^%s+", ""):gsub("%s+$", "")
		-- insert underscore before uppercase letters
		name = name:gsub("(%u)", "_%1"):lower()
		--remove end underscore if any
		name = name:gsub("^_", "")
		return name
	end

	local function is_numeric_type(type_str)
		local numeric_types = {
			"int",
			"int8",
			"int16",
			"int32",
			"int64",
			"uint",
			"uint8",
			"uint16",
			"uint32",
			"uint64",
			"float32",
			"float64",
			"byte",
			"rune",
		}

		type_str = type_str:gsub("^%*", "")

		for _, num_type in ipairs(numeric_types) do
			if type_str == num_type then
				return true
			end
		end
		return false
	end

	-- Process each line
	for i, line in ipairs(lines) do
		-- matches the fild name
		local field_name, field_type = line:match("^%s*(%w+)%s+(%*?%w+)")

		if field_name and field_type then
			-- if already has skip
			if not line:match("`") then
				local converted_name
				if case_style == "snake" then
					converted_name = to_snake_case(field_name)
				else
					converted_name = to_camel_case(field_name)
				end

				local tag_value

				if is_numeric_type(field_type) then
					tag_value = string.format('`%s:"%s"`', tag, converted_name)
				else
					tag_value = string.format('`%s:"%s,omitempty"`', tag, converted_name)
				end

				local clean_line = line:gsub("%s+$", "")
				lines[i] = clean_line .. " " .. tag_value
			end
		end
	end

	vim.api.nvim_buf_set_lines(0, line_start - 1, line_end, false, lines)

	vim.cmd("silent! write")
	local format_cmd = string.format("gofmt -w %s", vim.fn.shellescape(file))
	vim.fn.system(format_cmd)
	vim.cmd("edit!")
end, {
	nargs = "?",
	range = true,
	desc = "add JSON tags in camelCase with smart omitempty (excludes int/float types)",
})

vim.keymap.set("v", "<leader>tj", ":GoAddTagsSmart json camel<CR>", { desc = "add json tags" })
vim.keymap.set("v", "<leader>tjs", ":GoAddTagsSmart json snake<CR>", { desc = "add json tags with snake case" })
