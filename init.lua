vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.diagnostics")
require("plugins")
require("lsp.gopls")
require("lsp.templ")
