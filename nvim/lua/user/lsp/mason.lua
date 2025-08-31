local servers = {
    "lua_ls",
    "pyright",
    "jsonls",
    -- "ts_ls", -- Replaced with typescript-tools.nvim (configured in lsp/typescript-tools.lua)
    "clangd",
    "gopls",
    -- "elixirls", -- Replaced with Expert LSP
    "biome",
    "kotlin_language_server"
}

local manual_servers = {
    "sourcekit", -- Swift (installed via Swift toolchain)
    "expert", -- Elixir Expert LSP
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = false, -- Disable to prevent ts_ls auto-installation
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

-- Track which servers we've already configured
local configured_servers = {}

for _, server in pairs(servers) do
	-- Skip TypeScript servers - handled by typescript-tools.nvim
	if server == "ts_ls" or server == "tsserver" then
		goto continue
	end
	
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]
	
	-- Skip if already configured
	if configured_servers[server] then
		goto continue
	end
	configured_servers[server] = true

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
	::continue::
end

-- Define custom LSP configurations
local configs = require('lspconfig.configs')
if not configs.expert then
    configs.expert = {
        default_config = {
            cmd = { vim.fn.expand("~/.local/bin/expert") },
            filetypes = { "elixir", "eelixir", "heex" },
            root_dir = function(fname)
                return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
            end,
            settings = {}
        }
    }
end

-- Configure manually installed servers (e.g., sourcekit)
for _, server in pairs(manual_servers) do
    -- Skip TypeScript servers - handled by typescript-tools.nvim
    if server == "ts_ls" or server == "tsserver" or server == "typescript-go" then
        goto continue
    end
    
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }
    -- Load server-specific settings if they exist
    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end
    lspconfig[server].setup(opts)
    ::continue::
end

-- Custom configuration for JetBrains Kotlin LSP
--require('lspconfig.configs').kotlinlsp = {
--    default_config = {
--        cmd = { vim.fn.expand("~/.local/share/kotlin-lsp/kotlin-0/kotlin-lsp.sh") },
--        filetypes = { "kotlin" },
--        root_dir = function(fname)
--                local util = require("lspconfig.util")
--                return util.root_pattern("settings.gradle", "build.gradle", ".git")(fname)
--                    or util.path.dirname(fname)  -- Fallback to the file's directory
--            end,
--    },
--}
--lspconfig.kotlinlsp.setup({
--    on_attach = require("user.lsp.handlers").on_attach,
--    capabilities = require("user.lsp.handlers").capabilities,
--})

