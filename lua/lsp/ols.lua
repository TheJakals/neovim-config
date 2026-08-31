vim.lsp.config["ols"] = {
 init_options = {
  enable_checker_workspace_diagnostics = true,
  checker_args = "-vet",
}, cmd = { "ols" },
  filetypes = { "odin" },
  root_markers = { "ols.json", ".git" },
  init_options = {
    checker_args = "-vet -vet-shadowing",
  },
}
vim.lsp.enable("ols")
