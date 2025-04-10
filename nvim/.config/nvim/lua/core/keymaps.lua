vim.g.mapleader = " "
vim.g.maplocalleader = " "
--
-- -- keymap for buffers
-- vim.keymap.set("n", "<leader>bn", ":bn<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>bp", ":bp<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true })

-- Move through buffers like tabs (if using bufferline)
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })

-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<Leader>w", ":w<CR>", { silent = true })
vim.keymap.set("n", "<Leader>q", ":q<CR>", { silent = true })
vim.keymap.set("n", "<Leader>r", ":e<CR>", { silent = true })

-- Move normally between wrapped lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move to first symbol on the line
vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "H", "^")
-- Move to last symbol of the line
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "L", "$")

-- Shift + q - Quit
-- vim.keymap.set("n", "Q", "<C-W>q")

-- vv - Makes vertical split
vim.keymap.set("n", "vv", "<C-W>v")
-- ss - Makes horizontal split
vim.keymap.set("n", "ss", "<C-W>s")

-- Quick jumping between splits
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Indenting in visual mode (tab/shift+tab)
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Move to the end of yanked text after yank and paste
vim.cmd("vnoremap <silent> y y`]")
vim.cmd("vnoremap <silent> p p`]")
vim.cmd("nnoremap <silent> p p`]")

-- Space + Space to clean search highlight
vim.keymap.set("n", "<Leader>h", ":noh<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Esc>", ":nohlsearch<Bar>:echo<CR>", { silent = true, noremap = true })

-- Fixes pasting after visual selection.
vim.keymap.set("v", "p", '"_dP')
