-- i was never using it
-- vim.keymap.set("n", "<leader>bn", ":bn<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>bp", ":bp<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true })

-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<Leader>w", ":w<CR>", { silent = true })
vim.keymap.set("n", "<Leader>q", ":q<CR>", { silent = true })

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

vim.cmd("vnoremap <silent> y y`]")
vim.cmd("vnoremap <silent> p p`]")
vim.cmd("nnoremap <silent> p p`]")

-- vim.keymap.set("n", "<Leader>h", ":noh<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":nohlsearch<Bar>:echo<CR>", { silent = true, noremap = true })

-- Fixes pasting after visual selection.
vim.keymap.set("v", "p", '"_dP')

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<M-j>", ":cnext<CR>")
vim.keymap.set("n", "<M-k>", ":cprev<CR>")
