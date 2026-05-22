local map = vim.keymap.set

vim.pack.add({
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
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/windwp/nvim-ts-autotag",
})

-- Colorscheme
require("kanagawa").setup({ transparent = true })
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
require("lualine").setup({ options = { theme = "kanagawa" } })

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
    preview = { treesitter = false },
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

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end
  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({ results = file_paths }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

map("n", "<leader>a", function() harpoon:list():add() end,              { desc = "Harpoon add file" })
map("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
map("n", "<C-e>",     function() toggle_telescope(harpoon:list()) end,  { desc = "Harpoon telescope" })
map("n", "<C-1>",     function() harpoon:list():select(1) end)
map("n", "<C-2>",     function() harpoon:list():select(2) end)
map("n", "<C-3>",     function() harpoon:list():select(3) end)
map("n", "<C-4>",     function() harpoon:list():select(4) end)
map("n", "<leader>h", function() harpoon:list():prev() end, { desc = "Go to previous file"})
map("n", "<leader>l", function() harpoon:list():next() end, { desc = "Go to next file"})

-- Autotag
require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true,
  },
})
