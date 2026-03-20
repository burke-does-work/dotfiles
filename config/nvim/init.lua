vim.opt.number = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Black-hole deletes/changes (d/x/c never touch clipboard)
vim.keymap.set({'n', 'x'}, 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })
vim.keymap.set({'n', 'x'}, 'x', '"_x', { noremap = true })
vim.keymap.set('n', 'X', '"_X', { noremap = true })
vim.keymap.set({'n', 'x'}, 'c', '"_c', { noremap = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true })

-- Cut to clipboard
vim.keymap.set({'n', 'x'}, '<leader>d', 'd', { noremap = true })
vim.keymap.set('n', '<leader>D', 'D', { noremap = true })

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
