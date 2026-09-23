vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.omni_sql_no_default_maps = 1

require("config.options")
require("config.keymaps")
require("config.terminal")
require("config.autocmds")
require("config.diagnostics")
require("plugins")
require("lsp.gopls")
require("lsp.templ")
require("lsp.ols")
require("lsp.sqls")
