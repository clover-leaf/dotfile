return {
    cmd = { "elixir-ls" }, -- If using Mason, this is automatically resolved
    filetypes = { "elixir", "heex", "surface" },
    root_dir = require("lspconfig").util.root_pattern("mix.exs", ".git"),
    settings = {
        elixirLS = {
            dialyzerEnabled = false,  -- Speeds up analysis (enable if needed)
            fetchDeps = false,        -- Prevents automatic dependency fetching
            suggestSpecs = true       -- Enables type hints
        }
    }
}
