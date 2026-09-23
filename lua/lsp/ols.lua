vim.lsp.config["ols"] = {
  cmd = { "ols" },
  filetypes = { "odin" },
  root_markers = { "ols.json", ".git" },
  init_options = {
    enable_checker_workspace_diagnostics = true,
    checker_args = "-vet", -- -vet already includes -vet-shadowing
  },
}
vim.lsp.enable("ols")
