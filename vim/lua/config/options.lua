-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.g.vscode then
  vim.opt.cmdheight = 50000 -- Change to 2 or 3 if the panel still pops up
else
  vim.opt.clipboard = "unnamedplus"
  if vim.env.SSH_TTY and not vim.env.TMUX then
    local function paste()
      return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
    end
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
      },
      paste = { ["+"] = paste, ["*"] = paste },
    }
  end
  vim.g.autoformat = false
  if vim.env.TMUX then
    vim.g.snacks_animate = false
  end
end
