-- spacegrey.lua -- port of doom-emacs' doom-spacegrey theme
-- Source: http://kkga.github.io/spacegray/ (via doom-themes)
--
-- Options (set before `:colorscheme spacegrey`), mirroring the emacs defcustoms:
--   vim.g.spacegrey_brighter_comments = true  -- dark-cyan comments
--   vim.g.spacegrey_comment_bg        = true  -- subtle bg behind comments
--   vim.g.spacegrey_brighter_modeline = true  -- more vivid statusline

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "spacegrey"

-- color helpers (same math as doom-blend / doom-darken / doom-lighten)
local function rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

-- alpha * c1 + (1 - alpha) * c2
local function blend(c1, c2, alpha)
	local r1, g1, b1 = rgb(c1)
	local r2, g2, b2 = rgb(c2)
	local function mix(a, b)
		return math.floor(alpha * a + (1 - alpha) * b + 0.5)
	end
	return string.format("#%02x%02x%02x", mix(r1, r2), mix(g1, g2), mix(b1, b2))
end

local function darken(c, alpha)
	return blend(c, "#000000", 1 - alpha)
end

local function lighten(c, alpha)
	return blend(c, "#ffffff", 1 - alpha)
end

local brighter_comments = vim.g.spacegrey_brighter_comments == true
local comment_bg = vim.g.spacegrey_comment_bg
if comment_bg == nil then
	comment_bg = brighter_comments
end
local modeline_bright = vim.g.spacegrey_brighter_modeline == true

-- palette
local c = {
	bg = "#2b303b",
	bg_alt = "#232830",
	base0 = "#1B2229",
	base1 = "#1c1f24",
	base2 = "#202328",
	base3 = "#2F3237",
	base4 = "#4f5b66",
	base5 = "#65737E",
	base6 = "#73797e",
	base7 = "#9ca0a4",
	base8 = "#DFDFDF",
	fg = "#c0c5ce",
	fg_alt = "#c0c5ce",

	red = "#BF616A",
	orange = "#D08770",
	green = "#A3BE8C",
	blue = "#8FA1B3",
	violet = "#b48ead",
	teal = "#4db5bd",
	yellow = "#ECBE7B",
	dark_blue = "#2257A0",
	magenta = "#c678dd",
	cyan = "#46D9FF",
	dark_cyan = "#5699AF",
}
c.grey = c.base4

-- face categories
local highlight = c.orange
local vertical_bar = darken(c.bg, 0.25)
local selection = c.base4
local builtin = c.orange
local comments = brighter_comments and c.dark_cyan or c.base5
local doc_comments = lighten(comments, 0.25)
local constants = c.orange
local functions = c.blue
local keywords = c.violet
local methods = c.blue
local operators = c.fg
local type = c.yellow
local strings = c.green
local variables = c.red
local numbers = c.orange
local region = selection
local error = c.red
local warning = c.yellow
local success = c.green
local vc_modified = c.orange
local vc_added = c.green
local vc_deleted = c.red

local modeline_fg = c.fg
local modeline_fg_alt = blend(c.violet, c.base4, modeline_bright and 0.5 or 0.2)
local modeline_bg = modeline_bright and darken(c.base3, 0.1) or c.base1
local modeline_bg_inactive = darken(c.bg_alt, 0.05)

local groups = {
	-- editor
	Normal = { fg = c.fg, bg = c.bg },
	NormalNC = { link = "Normal" },
	NormalFloat = { fg = c.fg, bg = c.bg_alt },
	FloatBorder = { fg = c.base4, bg = c.bg_alt },
	FloatTitle = { fg = highlight, bg = c.bg_alt, bold = true },
	Cursor = { fg = c.bg, bg = highlight },
	lCursor = { link = "Cursor" },
	TermCursor = { link = "Cursor" },
	CursorLine = { bg = c.bg_alt },
	CursorColumn = { link = "CursorLine" },
	ColorColumn = { bg = c.bg_alt },
	LineNr = { fg = c.base4 },
	CursorLineNr = { fg = c.fg },
	SignColumn = { fg = c.base4, bg = c.bg },
	FoldColumn = { fg = c.base4, bg = c.bg },
	Folded = { fg = c.base5, bg = c.bg_alt },
	VertSplit = { fg = vertical_bar, bg = vertical_bar },
	WinSeparator = { fg = vertical_bar, bg = c.bg },
	Visual = { bg = region },
	VisualNOS = { link = "Visual" },
	Search = { fg = c.base8, bg = c.dark_blue },
	IncSearch = { fg = c.base8, bg = c.dark_blue, bold = true },
	CurSearch = { link = "IncSearch" },
	Substitute = { fg = c.base0, bg = error },
	MatchParen = { fg = c.red, bg = c.base0, bold = true },
	NonText = { fg = c.base5 },
	Whitespace = { fg = c.base4 },
	SpecialKey = { fg = c.base5 },
	EndOfBuffer = { fg = c.bg },
	Conceal = { fg = c.base5 },
	Directory = { fg = c.blue },
	Title = { fg = c.red, bold = true },
	ModeMsg = { fg = c.fg, bold = true },
	MoreMsg = { fg = highlight },
	Question = { fg = highlight },
	MsgArea = { fg = c.fg },
	ErrorMsg = { fg = error },
	WarningMsg = { fg = warning },
	QuickFixLine = { bg = region, bold = true },
	WildMenu = { fg = c.base0, bg = highlight },
	-- mode-line
	StatusLine = { fg = modeline_fg, bg = modeline_bg },
	StatusLineNC = { fg = modeline_fg_alt, bg = modeline_bg_inactive },
	WinBar = { fg = c.fg, bg = c.bg },
	WinBarNC = { fg = modeline_fg_alt, bg = c.bg },
	TabLine = { fg = c.base7, bg = c.base1 },
	TabLineFill = { bg = c.base1 },
	TabLineSel = { fg = c.fg, bg = c.bg, bold = true },
	-- popup menu
	Pmenu = { fg = c.fg, bg = c.bg_alt },
	PmenuSel = { fg = c.base8, bg = region },
	PmenuSbar = { bg = c.bg_alt },
	PmenuThumb = { bg = c.base4 },
	PmenuKind = { fg = c.violet, bg = c.bg_alt },
	PmenuExtra = { fg = c.base5, bg = c.bg_alt },
	-- spelling
	SpellBad = { sp = error, undercurl = true },
	SpellCap = { sp = warning, undercurl = true },
	SpellLocal = { sp = c.teal, undercurl = true },
	SpellRare = { sp = c.violet, undercurl = true },
	-- diff
	DiffAdd = { bg = blend(vc_added, c.bg, 0.15) },
	DiffChange = { bg = blend(vc_modified, c.bg, 0.1) },
	DiffDelete = { fg = vc_deleted, bg = blend(vc_deleted, c.bg, 0.15) },
	DiffText = { bg = blend(vc_modified, c.bg, 0.3) },
	Added = { fg = vc_added },
	Changed = { fg = vc_modified },
	Removed = { fg = vc_deleted },
	diffAdded = { fg = vc_added },
	diffRemoved = { fg = vc_deleted },
	diffChanged = { fg = vc_modified },
	diffFile = { fg = c.blue, bold = true },
	diffLine = { fg = c.violet },

	-- syntax
	Comment = { fg = comments, bg = comment_bg and lighten(c.bg, 0.05) or nil },
	Constant = { fg = constants },
	String = { fg = strings },
	Character = { fg = strings },
	Number = { fg = numbers },
	Boolean = { fg = constants },
	Float = { fg = numbers },
	Identifier = { fg = c.fg },
	Function = { fg = functions },
	Statement = { fg = keywords },
	Conditional = { fg = keywords },
	Repeat = { fg = keywords },
	Label = { fg = keywords },
	Operator = { fg = operators },
	Keyword = { fg = keywords },
	Exception = { fg = keywords },
	PreProc = { fg = keywords },
	Include = { fg = keywords },
	Define = { fg = keywords },
	Macro = { fg = builtin },
	PreCondit = { fg = keywords },
	Type = { fg = type },
	StorageClass = { fg = keywords },
	Structure = { fg = type },
	Typedef = { fg = type },
	Special = { fg = builtin },
	SpecialChar = { fg = c.teal },
	Tag = { fg = c.red },
	Delimiter = { fg = c.fg },
	SpecialComment = { fg = doc_comments },
	Debug = { fg = c.red },
	Underlined = { fg = highlight, underline = true },
	Ignore = { fg = c.base5 },
	Error = { fg = error },
	Todo = { fg = c.yellow, bold = true },

	-- treesitter
	["@variable"] = { fg = c.fg },
	["@variable.builtin"] = { fg = builtin },
	["@variable.parameter"] = { fg = c.fg },
	["@variable.member"] = { fg = variables },
	["@property"] = { fg = variables },
	["@constant"] = { fg = constants },
	["@constant.builtin"] = { fg = builtin },
	["@constant.macro"] = { fg = constants },
	["@module"] = { fg = c.fg },
	["@module.builtin"] = { fg = builtin },
	["@label"] = { fg = keywords },
	["@string"] = { link = "String" },
	["@string.documentation"] = { fg = doc_comments },
	["@string.regexp"] = { fg = c.teal },
	["@string.escape"] = { fg = c.teal },
	["@string.special"] = { fg = c.teal },
	["@string.special.url"] = { fg = highlight, underline = true },
	["@character"] = { link = "Character" },
	["@character.special"] = { fg = c.teal },
	["@boolean"] = { link = "Boolean" },
	["@number"] = { link = "Number" },
	["@number.float"] = { link = "Float" },
	["@type"] = { fg = type },
	["@type.builtin"] = { fg = type },
	["@type.definition"] = { fg = type },
	["@attribute"] = { fg = builtin },
	["@function"] = { fg = functions },
	["@function.builtin"] = { fg = builtin },
	["@function.call"] = { fg = functions },
	["@function.macro"] = { fg = builtin },
	["@function.method"] = { fg = methods },
	["@function.method.call"] = { fg = methods },
	["@constructor"] = { fg = type },
	["@operator"] = { fg = operators },
	["@keyword"] = { fg = keywords },
	["@keyword.function"] = { fg = keywords },
	["@keyword.operator"] = { fg = keywords },
	["@keyword.return"] = { fg = keywords },
	["@keyword.import"] = { fg = keywords },
	["@keyword.directive"] = { fg = keywords },
	["@punctuation.delimiter"] = { fg = c.fg },
	["@punctuation.bracket"] = { fg = c.fg },
	["@punctuation.special"] = { fg = c.teal },
	["@comment"] = { link = "Comment" },
	["@comment.documentation"] = { fg = doc_comments },
	["@comment.error"] = { fg = error, bold = true },
	["@comment.warning"] = { fg = warning, bold = true },
	["@comment.todo"] = { fg = c.yellow, bold = true },
	["@comment.note"] = { fg = c.teal, bold = true },
	["@tag"] = { fg = c.red },
	["@tag.builtin"] = { fg = c.red },
	["@tag.attribute"] = { fg = c.orange },
	["@tag.delimiter"] = { fg = c.base7 },
	["@diff.plus"] = { fg = vc_added },
	["@diff.minus"] = { fg = vc_deleted },
	["@diff.delta"] = { fg = vc_modified },
	-- markup (markdown-mode overrides)
	["@markup.heading"] = { fg = c.red, bold = true },
	["@markup.strong"] = { bold = true },
	["@markup.italic"] = { italic = true },
	["@markup.strikethrough"] = { strikethrough = true },
	["@markup.underline"] = { underline = true },
	["@markup.quote"] = { fg = c.base7, bg = c.base1, italic = true },
	["@markup.math"] = { fg = c.teal },
	["@markup.link"] = { fg = c.blue },
	["@markup.link.label"] = { fg = c.blue },
	["@markup.link.url"] = { fg = highlight, underline = true },
	["@markup.raw"] = { fg = c.green, bg = darken(c.bg, 0.1) },
	["@markup.raw.block"] = { fg = c.fg, bg = darken(c.bg, 0.1) },
	["@markup.list"] = { fg = c.base5 },
	["@markup.list.checked"] = { fg = success },
	["@markup.list.unchecked"] = { fg = c.base5 },
	-- css-mode overrides
	["@property.css"] = { fg = c.fg },
	["@property.scss"] = { fg = c.fg },
	["@tag.css"] = { fg = c.red },
	["@tag.scss"] = { fg = c.red },

	-- lsp
	["@lsp.type.variable"] = {},
	["@lsp.type.parameter"] = { link = "@variable.parameter" },
	["@lsp.type.property"] = { link = "@property" },
	["@lsp.type.namespace"] = { link = "@module" },
	["@lsp.type.enumMember"] = { link = "@constant" },
	["@lsp.type.macro"] = { link = "@function.macro" },
	["@lsp.mod.deprecated"] = { strikethrough = true },
	["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
	["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
	LspReferenceText = { bg = c.base3 },
	LspReferenceRead = { bg = c.base3 },
	LspReferenceWrite = { bg = c.base3, bold = true },
	LspSignatureActiveParameter = { fg = highlight, bold = true },
	LspInlayHint = { fg = c.base5, bg = blend(c.base4, c.bg, 0.2) },
	LspCodeLens = { fg = c.base5 },
	LspInfoBorder = { link = "FloatBorder" },

	-- diagnostics
	DiagnosticError = { fg = error },
	DiagnosticWarn = { fg = warning },
	DiagnosticInfo = { fg = c.blue },
	DiagnosticHint = { fg = c.teal },
	DiagnosticOk = { fg = success },
	DiagnosticUnderlineError = { sp = error, undercurl = true },
	DiagnosticUnderlineWarn = { sp = warning, undercurl = true },
	DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true },
	DiagnosticUnderlineHint = { sp = c.teal, undercurl = true },
	DiagnosticUnderlineOk = { sp = success, undercurl = true },
	DiagnosticVirtualTextError = { fg = error, bg = blend(error, c.bg, 0.1) },
	DiagnosticVirtualTextWarn = { fg = warning, bg = blend(warning, c.bg, 0.1) },
	DiagnosticVirtualTextInfo = { fg = c.blue, bg = blend(c.blue, c.bg, 0.1) },
	DiagnosticVirtualTextHint = { fg = c.teal, bg = blend(c.teal, c.bg, 0.1) },
	DiagnosticUnnecessary = { fg = c.base5 },
	DiagnosticDeprecated = { strikethrough = true },

	-- telescope
	TelescopeNormal = { fg = c.fg, bg = c.bg_alt },
	TelescopeBorder = { fg = c.base4, bg = c.bg_alt },
	TelescopeTitle = { fg = highlight, bold = true },
	TelescopePromptPrefix = { fg = highlight },
	TelescopeSelection = { fg = c.base8, bg = region },
	TelescopeSelectionCaret = { fg = highlight, bg = region },
	TelescopeMultiSelection = { fg = c.violet },
	TelescopeMatching = { fg = highlight, bold = true },

	-- nvim-cmp
	CmpItemAbbr = { fg = c.fg },
	CmpItemAbbrDeprecated = { fg = c.base5, strikethrough = true },
	CmpItemAbbrMatch = { fg = highlight, bold = true },
	CmpItemAbbrMatchFuzzy = { fg = highlight },
	CmpItemMenu = { fg = c.base5 },
	CmpItemKind = { fg = c.violet },
	CmpItemKindFunction = { fg = functions },
	CmpItemKindMethod = { fg = methods },
	CmpItemKindConstructor = { fg = type },
	CmpItemKindVariable = { fg = variables },
	CmpItemKindField = { fg = variables },
	CmpItemKindProperty = { fg = variables },
	CmpItemKindClass = { fg = type },
	CmpItemKindInterface = { fg = type },
	CmpItemKindStruct = { fg = type },
	CmpItemKindModule = { fg = c.blue },
	CmpItemKindKeyword = { fg = keywords },
	CmpItemKindConstant = { fg = constants },
	CmpItemKindEnum = { fg = type },
	CmpItemKindEnumMember = { fg = constants },
	CmpItemKindSnippet = { fg = c.teal },
	CmpItemKindText = { fg = strings },
	CmpItemKindFile = { fg = c.blue },
	CmpItemKindFolder = { fg = c.blue },

	-- mini.diff
	MiniDiffSignAdd = { fg = vc_added },
	MiniDiffSignChange = { fg = vc_modified },
	MiniDiffSignDelete = { fg = vc_deleted },
	MiniDiffOverAdd = { bg = blend(vc_added, c.bg, 0.15) },
	MiniDiffOverChange = { bg = blend(vc_modified, c.bg, 0.15) },
	MiniDiffOverContext = { bg = c.bg_alt },
	MiniDiffOverDelete = { bg = blend(vc_deleted, c.bg, 0.15) },

	-- treesitter-context
	TreesitterContext = { bg = c.bg_alt },
	TreesitterContextLineNumber = { fg = c.base5, bg = c.bg_alt },
	TreesitterContextBottom = { sp = c.base4, underline = true },

	-- oil
	OilDir = { fg = c.blue, bold = true },
	OilFile = { fg = c.fg },
	OilLink = { fg = c.teal },
	OilCreate = { fg = vc_added },
	OilDelete = { fg = vc_deleted },
	OilMove = { fg = vc_modified },
	OilCopy = { fg = c.violet },
	OilChange = { fg = vc_modified },

	-- fugitive
	fugitiveHeader = { fg = c.blue, bold = true },
	fugitiveHeading = { fg = c.violet, bold = true },
	fugitiveUntrackedHeading = { fg = c.yellow, bold = true },
	fugitiveUnstagedHeading = { fg = c.orange, bold = true },
	fugitiveStagedHeading = { fg = c.green, bold = true },
	fugitiveUntrackedModifier = { fg = c.yellow },
	fugitiveUnstagedModifier = { fg = c.orange },
	fugitiveStagedModifier = { fg = c.green },
	fugitiveHash = { fg = c.base5 },
	fugitiveSymbolicRef = { fg = c.teal },
	fugitiveCount = { fg = c.base7 },
	gitcommitSummary = { fg = c.fg },
	gitcommitOverflow = { fg = error },
}

for name, spec in pairs(groups) do
	vim.api.nvim_set_hl(0, name, spec)
end

-- terminal colors
local term = {
	c.base0, c.red, c.green, c.yellow, c.blue, c.violet, c.dark_cyan, c.fg,
	c.base5, c.orange, c.green, c.yellow, c.blue, c.magenta, c.teal, c.base8,
}
for i, color in ipairs(term) do
	vim.g["terminal_color_" .. (i - 1)] = color
end
