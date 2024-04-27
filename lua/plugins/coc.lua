return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    event = "VeryLazy",
    vscode = true,
    init = function()
      vim.g.coc_global_extensions = { "coc-discord-rpc" }
      vim.g.coc_config_home = vim.fn.stdpath("config") .. "/lua/config"
    end,
  },
}
