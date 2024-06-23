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
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Save undo history
vim.o.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

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

-- Open splits on the right and below
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Update vim after file update from outside
vim.opt.autoread = true
-- Create an autocmd group for reloading files
local augroup = vim.api.nvim_create_augroup("AutoReload", { clear = true })

-- Check for file changes on `CursorHold`, `BufEnter`, and `FocusGained`
vim.api.nvim_create_autocmd({ "CursorHold", "BufEnter", "FocusGained" }, {
	group = augroup,
	command = "checktime",
})

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.cmd("set expandtab")

-- Always use spaces instead of tabs
vim.opt.expandtab = true

-- Don't wrap lines
vim.opt.wrap = true
-- Wrap lines at convenient points
vim.opt.linebreak = true
-- Show line breaks
vim.opt.showbreak = "↳"

-- Start scrolling when we are 8 lines away from borders
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 5

-- This makes vim act like all other editors, buffers can
-- exist in the background without being in a window.
vim.opt.hidden = true
