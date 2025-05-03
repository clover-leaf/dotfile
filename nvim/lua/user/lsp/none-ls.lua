local none_ls_status_ok, none_ls = pcall(require, "none-ls")
if not none_ls_status_ok then
  return
end

-- Updated builtins reference
local formatting = none_ls.builtins.formatting
-- local diagnostics = none_ls.builtins.diagnostics  -- Uncomment if needed

none_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({
      filetypes = {
        "javascript",
        "typescript",
        "typescriptreact",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        "markdown",
        "graphql",
        "md",
        "txt",
      },
    }),
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
  },
})

-- Optional: Connect to LSP (only needed if not auto-attached)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == "none-ls" then
      -- Your LSP keymaps here
    end
  end,
})
