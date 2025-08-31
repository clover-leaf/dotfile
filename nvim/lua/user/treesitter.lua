local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

local options = {
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "javascript",
    "typescript",
    "java",
    "python",
    "bash",
    "cmake",
    "json5",
    "gitignore",
    "css",
    "tsx",
    "json",
    "vim",
    "dockerfile",
    "html",
    "css",
    "yaml",
    "markdown",
    "sql",
    "go",
    "elixir",
    "eex",
    "heex",
    "swift"
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    disable = { "jsx", "tsx" }, -- list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  highlight = {
    enable = true,
    disable = {"jsx", "tsx"},
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  }
}

treesitter.setup(options)

