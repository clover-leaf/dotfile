return {
    cmd = { vim.fn.expand("~/.local/bin/expert") },
    filetypes = { "elixir", "eelixir", "heex" },
    root_dir = function(fname)
        return require("lspconfig").util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
    end,
    settings = {
        -- Expert LSP settings can be added here when available
    }
}