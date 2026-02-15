return {
  cmd = { "sourcekit-lsp" },
  filetypes = { "swift" },
  root_dir = require("lspconfig.util").root_pattern(
    "buildServer.json", -- xcode-build-server (Xcode projects)
    "Package.swift",    -- Swift Package Manager
    ".xcodeproj",
    ".xcworkspace",
    ".git"
  ),
}
