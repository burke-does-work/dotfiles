vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.clipboard = "unnamedplus"
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.hlsearch = false

-- <Space>d/x/c: send to blackhole register (no clipboard effect)
vim.keymap.set({'n', 'x'}, '<leader>d', '"_d', { noremap = true })
vim.keymap.set('n',        '<leader>dd', '"_dd', { noremap = true })
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
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        italic = {
          strings = false,
          emphasis = true,
          comments = false,
          operators = false,
          folds = false,
        },
        -- Gruvbox maps all six heading levels, code and quotes onto one
        -- green. Spread them across the palette, ordered by how far each
        -- colour sits from the body-text cream.
        overrides = {
          ["@markup.heading.1"] = { fg = "#928374", bold = true },
          ["@markup.heading.2"] = { fg = "#d65d0e", bold = true },
          ["@markup.heading.3"] = { fg = "#d3869b", bold = true },
          ["@markup.heading.4"] = { fg = "#83a598", bold = true },
          ["@markup.heading.5"] = { fg = "#fe8019", bold = true },
          ["@markup.heading.6"] = { fg = "#8ec07c", bold = true },
          ["@markup.strong"] = { fg = "#8ec07c", bold = true },
          ["@markup.quote"] = { fg = "#928374" },
          ["@markup.raw"] = { fg = "#a89984" },
          ["@markup.raw.block"] = { fg = "#a89984" },
        },
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
})
