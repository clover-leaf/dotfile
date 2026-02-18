local util = require("lspconfig.util")

return {
  single_file_support = true,
  root_dir = function(fname)
    return util.root_pattern("settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts")(fname)
      or util.find_git_ancestor(fname)
      or util.path.dirname(fname)
  end,
  -- vim.empty_dict() forces JSON serialization as {} instead of [].
  -- Without this, Lua's empty {} becomes [], which crashes kotlin-language-server's
  -- getStoragePath (expects object, gets array).
  init_options = vim.empty_dict(),
}
