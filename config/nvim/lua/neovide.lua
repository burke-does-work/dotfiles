-- Neovide overlay.
--
-- Loaded from init.lua only when nvim runs inside Neovide (vim.g.neovide).
-- Holds GUI-only behavior: font, theme, mouse, and window settings.
-- Editing behavior (motions, leader maps, registers, plugins) stays in
-- init.lua so the terminal and GUI layers share one mental model.

-- Font: matches Ghostty. Contextual alternates (calt) are on by default.
vim.o.guifont = "CommitMono Nerd Font:h13"

-- Padding: matches Ghostty.
vim.g.neovide_padding_left = 16
vim.g.neovide_padding_right = 16
vim.g.neovide_padding_top = 12
vim.g.neovide_padding_bottom = 12

-- No motion: cursor, scroll, and window moves are instant, like Ghostty.
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_short_animation_length = 0
vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_position_animation_length = 0

-- Colours: jellybeans, separate from terminal nvim's gruvbox. Overrides only
-- where jellybeans leaves markdown elements looking alike.
require("jellybeans").setup({
  on_highlights = function(hl)
    hl["@markup.strong"] = { fg = "#70b950", bold = true } -- H5 shares the pink
    hl["@markup.quote"] = { fg = "#535d66" } -- dim, but visible when selected
  end,
})
vim.cmd("colorscheme jellybeans")
