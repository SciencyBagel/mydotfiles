-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false
vim.opt.ttimeoutlen = 10
vim.opt.colorcolumn = "120"

vim.filetype.add({
  extension = {
    tcss = "css",
  },
})

vim.diagnostic.config({
  update_in_insert = true, -- Update diagnostics while typing
  virtual_text = {
    prefix = "●",
  },
  severity_sort = true,
})
