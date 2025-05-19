local Terminal = require("toggleterm.terminal").Terminal

-- LazyGit terminal
local lazygit = Terminal:new({
  cmd = "lazygit",  -- Ensure `lazygit` is installed (brew install lazygit)
  dir = "git_dir",   -- Open in repo root (auto-detects .git)
  direction = "float",
  float_opts = {
    border = "double",  -- Border style (single, double, shadow, etc.)
  },
  -- Close with `q` or `Esc`
  on_open = function(term)
    vim.cmd("startinsert!")  -- Enter insert mode automatically
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

-- Toggle LazyGit with <leader>gg
vim.keymap.set("n", "<leader>gg", function()
  lazygit:toggle()
end, { desc = "Toggle lazygit" })

