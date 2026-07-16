-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Bind Table of Contents generation to <leader>mt
vim.keymap.set("n", "<leader>mt", function()
  -- If you use mzlogin/vim-markdown-toc
  vim.cmd("Mtoc insert")
  -- Alternatively, if you use hedyhli/markdown-toc.nvim, use: vim.cmd("Mtoc insert")
end, { desc = "Markdown Generate TOC" })
