local uv = vim.uv or vim.loop
local in_vscode = not not vim.g.vscode

local function path_exists(path)
  return path ~= nil and path ~= "" and uv.fs_stat(path) ~= nil
end

local function discord_temp_prefix()
  return vim.env.XDG_RUNTIME_DIR
    or vim.env.TMPDIR
    or vim.env.TMP
    or vim.env.TEMP
    or "/tmp"
end

local function discord_ipc_available()
  if vim.fn.has("win32") == 1 then
    for i = 0, 9 do
      if path_exists("\\\\?\\pipe\\discord-ipc-" .. i) then
        return true
      end
    end

    return false
  end

  local prefix = discord_temp_prefix()
  for i = 0, 9 do
    if path_exists(prefix .. "/discord-ipc-" .. i) then
      return true
    end
  end

  return false
end

local function coc_enabled()
  if in_vscode then
    return true
  end

  return discord_ipc_available()
end

local coc = {
  "neoclide/coc.nvim",
  branch = "release",
  enabled = coc_enabled,
  vscode = true,
  init = function()
    vim.g.coc_global_extensions = { "coc-discord-rpc" }
    vim.g.coc_config_home = vim.fn.stdpath("config") .. "/lua/config"
  end,
}

if in_vscode then
  coc.lazy = false
else
  coc.event = "VeryLazy"
end

return { coc }
