local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--
-- Key
--   C = Ctrl
--   A = Alt
--   S = Shift
--   Leader = Space

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Close current pane
keymap("n", "<C-w>q", "<C-w>q", opts)
keymap("n", "<leader>q", "<C-w>q", opts)

-- keymap("n", "<leader>e", ":Lex 30<cr>", opts) -- Disabled for telescope file browser

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader><leader>", "<C-^>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "tn", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m .+1<CR>gv", opts)
keymap("v", "K", ":m .-2<CR>gv", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false, hidden = true }))<cr>", opts)
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

-- Telescope File Browser
keymap("n", "<leader>e", "<cmd>Telescope file_browser<cr>", opts)
keymap("n", "<leader>u", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", opts)

-- Reload config
keymap("n", "<leader>rr", "<cmd>source $MYVIMRC | lua require('lazy.core.loader').reload()<CR>", opts)

-- Toggle line wrap
keymap("n", "<leader>w", ":set wrap!<CR>", opts)

-- NoNeckPain (centering/focus mode)
keymap("n", "<leader>n", ":NoNeckPain<CR>", opts)

-- movement
keymap("n", "<leader>j", "<C-d>", opts)
keymap("n", "<leader>k", "<C-u>", opts)

-- Quickfix navigation
keymap("n", "<leader>cc", ":cclose<CR>", opts)
keymap("n", "<leader>co", ":copen<CR>", opts)
keymap("n", "<leader>cw", "<C-w>w", opts)
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)

-- LSP status check
keymap("n", "<leader>li", ":LspInfo<CR>", opts)
keymap("n", "<leader>ls", ":lua print('LSP Status: ' .. vim.inspect(vim.lsp.get_active_clients()))<CR>", opts)

-- LSP debug keymap
keymap("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<leader>lc", ":lua for _, client in ipairs(vim.lsp.get_active_clients()) do print('LSP Client:', client.name) end<CR>", opts)

-- Diagnostics (workspace-wide)
keymap("n", "<leader>dw", "<cmd>Telescope diagnostics<cr>", opts)  -- Workspace diagnostics (searchable)
keymap("n", "<leader>dd", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)  -- Current buffer diagnostics
keymap("n", "<leader>dq", "<cmd>lua vim.diagnostic.setqflist()<cr>", opts)  -- All diagnostics to quickfix
keymap("n", "<leader>dp", "<cmd>lua require('user.lsp.handlers').check_project_diagnostics()<cr>", opts)  -- Check entire project

-- Markview (Markdown rendering)
keymap("n", "<leader>mv", ":Markview<CR>", opts)
keymap("n", "<leader>mt", ":Markview toggle<CR>", opts)

-- Markdown Preview (for mermaid charts)
keymap("n", "<leader>mp", ":MarkdownPreview<CR>", opts)
keymap("n", "<leader>ms", ":MarkdownPreviewStop<CR>", opts)
