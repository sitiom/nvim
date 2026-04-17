local is_wsl = vim.fn.has("wsl") == 1
local is_termux = vim.fn.has("termux") == 1
  or vim.env.TERMUX_VERSION ~= nil
  or vim.env.PREFIX == "/data/data/com.termux/files/usr"

return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    event = "VeryLazy",
    enabled = not (is_wsl or is_termux),
    vscode = true,
    init = function()
      vim.g.coc_global_extensions = { "coc-discord-rpc" }
      vim.g.coc_config_home = vim.fn.stdpath("config") .. "/lua/config"
    end,
  },
}
