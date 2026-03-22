vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.hlsearch = false

-- <Space>d/x/c: send to blackhole register (no clipboard effect)
vim.keymap.set({'n', 'x'}, '<leader>d', '"_d', { noremap = true })
vim.keymap.set('n',        '<leader>D', '"_D', { noremap = true })
vim.keymap.set({'n', 'x'}, '<leader>x', '"_x', { noremap = true })
vim.keymap.set('n',        '<leader>X', '"_X', { noremap = true })
vim.keymap.set({'n', 'x'}, '<leader>c', '"_c', { noremap = true })
vim.keymap.set('n',        '<leader>C', '"_C', { noremap = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  { "dhruvasagar/vim-table-mode" },
})
