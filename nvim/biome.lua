return {
  on_attach = function(client, bufnr)
    -- Only format on save if Biome is active
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        if vim.fn.executable("biome") == 1 then
          vim.lsp.buf.format({
            filter = function(client)
              return client.name == "biome"
            end,
            async = false,
          })
        end
      end,
    })
  end,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
  single_file_support = true,  -- Important for per-file formatting
}
