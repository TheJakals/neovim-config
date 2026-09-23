local opt = vim.opt

-- Shared Clipboard
opt.clipboard = "unnamedplus"

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 8
opt.shiftwidth = 8
opt.expandtab = true
opt.smartindent = true -- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 12
opt.wrap = false
opt.splitright = true
opt.splitbelow = true
opt.winborder = "rounded"  -- border on floating windows (hover, signature help)
opt.numberwidth = 4
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Completion (0.12 native)
opt.autocomplete = true
opt.complete = "o,."                              -- LSP (omnifunc) first, then buffer words
opt.completeopt = "menuone,noselect,popup,fuzzy"  -- "popup" shows docs for selected item
