local M = {}

-- Check all TypeScript files in project and show diagnostics
M.check_project_diagnostics = function()
  local project_root = vim.fn.getcwd()
  print("Scanning project for TypeScript files...")

  -- Find all TS/TSX files and open them to trigger LSP
  vim.fn.jobstart(
    string.format("find '%s' -type f \\( -name '*.ts' -o -name '*.tsx' \\) 2>/dev/null | head -100", project_root),
    {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          local count = 0
          for _, file in ipairs(data) do
            if file ~= "" then
              -- Open file in hidden buffer to trigger LSP
              vim.cmd("badd " .. vim.fn.fnameescape(file))
              count = count + 1
            end
          end
          if count > 0 then
            vim.defer_fn(function()
              print(string.format("Loaded %d files. Press <leader>xx to view diagnostics", count))
            end, 2000)
          end
        end
      end,
    }
  )
end

-- Get diagnostics for a specific folder
M.get_folder_diagnostics = function(folder_path)
  folder_path = folder_path or vim.fn.input("Folder path: ", vim.fn.getcwd() .. "/", "file")
  if folder_path == "" then return end

  -- Normalize path
  folder_path = vim.fn.fnamemodify(folder_path, ":p")

  local all_diagnostics = vim.diagnostic.get()
  local folder_diagnostics = {}

  for _, diagnostic in ipairs(all_diagnostics) do
    local bufnr = diagnostic.bufnr
    local buf_name = vim.api.nvim_buf_get_name(bufnr)

    -- Check if buffer is in the specified folder
    if buf_name:find(folder_path, 1, true) == 1 then
      table.insert(folder_diagnostics, diagnostic)
    end
  end

  if #folder_diagnostics == 0 then
    print("No diagnostics found in: " .. folder_path)
    return
  end

  vim.diagnostic.setqflist(folder_diagnostics)
  print("Found " .. #folder_diagnostics .. " diagnostics in: " .. folder_path)
  vim.cmd("copen")
end

M.setup = function()
  -- Modern diagnostic configuration (replaces deprecated sign_define)
  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs with modern approach
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      }
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- Additional documentation keymaps
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>df", "<cmd>lua require('user.lsp.handlers').get_folder_diagnostics()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  vim.keymap.set("n", "<leader>bf", function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "biome"
      end,
      async = false,
      range = {
        start = { 1, 0 },
        ['end'] = { vim.fn.line("$"), 0 }
      }
    })
  end, { desc = "Format with Biome" })
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M
