-- for folding

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true
-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- No swap files
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

-- Save undo history
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Don't show modes (insert/visual)
-- vim.opt.showmode = false

vim.o.splitbelow = true
vim.o.splitright = true

-- Update vim after file update from outside
vim.o.autoread = true
-- Create an autocmd group for reloading files
local augroup = vim.api.nvim_create_augroup("AutoReload", { clear = true })

-- Check for file changes on `CursorHold`, `BufEnter`, and `FocusGained`
vim.api.nvim_create_autocmd({ "CursorHold", "BufEnter", "FocusGained" }, {
	group = augroup,
	command = "checktime",
})

-- Indentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.cmd("set expandtab") -- i dont know what is this

-- Always use spaces instead of tabs
vim.o.expandtab = true

-- Don't wrap lines
vim.o.wrap = false
-- Wrap lines at convenient points
-- vim.o.linebreak = true
-- Show line breaks
-- vim.o.showbreak = "↳"

-- Start scrolling when we are 8 lines away from borders
vim.o.scrolloff = 8
vim.o.sidescrolloff = 15
vim.o.sidescroll = 5

-- This makes vim act like all other editors, buffers can
-- exist in the background without being in a window.
vim.o.hidden = true -- dont know what it is
