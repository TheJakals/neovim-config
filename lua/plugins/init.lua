local map = vim.keymap.set

vim.pack.add({
  -- Colorshemes
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/joerdav/templ.vim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})

-- Colorscheme
require("kanagawa").setup({ transparent = true })
-- Default options:

vim.cmd.colorscheme("kanagawa")

-- Treesitter
require("nvim-treesitter").install({
  "lua", "go", "templ", "html", "css", "javascript", "typescript", "json", "bash"
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Mason
require("mason").setup()

-- Gitsigns
require("gitsigns").setup()

-- Lazygit
map("n", "<leader>gg", "<cmd>LazyGit<cr>")

-- Lualine
require("lualine").setup({ options = { theme = "tokyonight" } })

-- Autopairs
require("nvim-autopairs").setup()

-- Formatting
require("conform").setup({
  formatters_by_ft = {
    go = { "gofmt" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    html = { "prettier" },
    templ = { "templ" },
  },
  format_on_save = { timeout_ms = 500 },
})

-- Which-key
require("which-key").setup()

-- Telescope
require("telescope").setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.55 },
    border = true,
    prompt_prefix = " ",
    selection_caret = " ",
    preview = {
      treesitter = false,
    },
  },
  extensions = { fzf = {} },
})
require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fh", builtin.help_tags)
map("n", "<leader>fc", builtin.colorscheme)
map("n", "<leader>fd", builtin.diagnostics)
map("n", "<leader>fr", builtin.oldfiles)
