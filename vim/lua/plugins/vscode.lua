if not vim.g.vscode then
  return {}
end

local enabled = {
  "LazyVim",
  -- "dial.nvim",
  -- "flit.nvim",
  "hop.nvim",
  "lazy.nvim",
  -- "leap.nvim",
  "mini.ai",
  -- "mini.comment",
  -- "mini.move",
  "mini.pairs",
  "mini.surround",
  -- "nvim-ts-context-commentstring",
  -- "nvim-treesitter/nvim-treesitter",
  -- "nvim-treesitter/nvim-treesitter-textobjects",
  "snacks.nvim",
  "ts-comments.nvim",
  -- "vim-repeat",
  -- "yanky.nvim",
  "which-key.nvim",
}

local Config = require("lazy.core.config")
local vscode = require("vscode")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

vim.notify = vscode.notify

return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = false,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    enabled = false,
  },
}
