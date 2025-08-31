local status_ok, typescript_tools = pcall(require, "typescript-tools")
if not status_ok then
    return
end

typescript_tools.setup({
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
    settings = {
        -- spawn additional tsserver instance to calculate diagnostics on it
        separate_diagnostic_server = false, -- Changed to false to prevent duplicate servers
        -- "change"|"insert_leave" determine when the client asks the server about diagnostic  
        publish_diagnostic_on = "insert_leave",
        -- specify a list of plugins to load by tsserver, e.g., for support of styled-components
        tsserver_plugins = {},
        -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
        -- memory limit in megabytes or "auto"(basically no limit)
        tsserver_max_memory = "auto",
        -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
        complete_function_calls = true,
        include_completions_with_insert_text = true,
        -- CodeLens
        code_lens = "off",
        -- by default code lenses are displayed on all referencable values and for some of you it can
        -- be too much this option reduce count of them by removing member references from lenses
        disable_member_code_lens = true,
        -- JSXCloseTag
        jsx_close_tag = {
            enable = false,
            filetypes = { "javascriptreact", "typescriptreact" },
        },
        tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            importModuleSpecifier = "relative",
            includePackageJsonAutoImports = "auto",
        },
    },
    -- Add handlers to prevent duplicates
    handlers = {
        ["textDocument/definition"] = function(err, result, method, ...)
            if result and vim.tbl_islist(result) and #result > 1 then
                -- Remove exact duplicates
                local filtered_result = {}
                local seen = {}
                for _, res in ipairs(result) do
                    local key = res.uri .. ":" .. res.range.start.line .. ":" .. res.range.start.character
                    if not seen[key] then
                        seen[key] = true
                        table.insert(filtered_result, res)
                    end
                end
                result = filtered_result
            end
            vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
        end,
        ["textDocument/references"] = function(err, result, method, ...)
            if result and vim.tbl_islist(result) and #result > 1 then
                -- Remove exact duplicates
                local filtered_result = {}
                local seen = {}
                for _, res in ipairs(result) do
                    local key = res.uri .. ":" .. res.range.start.line .. ":" .. res.range.start.character
                    if not seen[key] then
                        seen[key] = true
                        table.insert(filtered_result, res)
                    end
                end
                result = filtered_result
            end
            vim.lsp.handlers["textDocument/references"](err, result, method, ...)
        end,
    }
})