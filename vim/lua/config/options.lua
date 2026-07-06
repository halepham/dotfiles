-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.g.vscode then
  vim.opt.cmdheight = 50000 -- Change to 2 or 3 if the panel still pops up
else
  vim.opt.clipboard = "unnamedplus"
  vim.g.autoformat = false
end
