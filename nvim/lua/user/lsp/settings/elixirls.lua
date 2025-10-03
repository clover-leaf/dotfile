return {
    cmd = {
        vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh"
    },
    filetypes = { "elixir", "heex", "surface" },
    root_dir = require("lspconfig").util.root_pattern("mix.exs", ".git"),
    settings = {
        elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = true, -- Enable to get documentation from dependencies
            suggestSpecs = true,
            enableTestLenses = false,
            mixEnv = "dev", -- Use dev environment for better docs
            projectDir = "", -- Use project root
            signatureAfterComplete = true -- Show signatures after completion
        }
    }
}
