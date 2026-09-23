vim.lsp.config["sqls"] = {
  cmd = { "sqls" },
  filetypes = { "sql", "mysql", "plsql" },
  root_markers = { ".sqls", ".git" },
  on_attach = function(client)
    -- sqls formatting is weak; leave formatting to conform (or nothing)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
vim.lsp.enable("sqls")
