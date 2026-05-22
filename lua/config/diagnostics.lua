vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    prefix = "●",      -- icon before the message
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,   -- only show errors in normal mode
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,            -- shows which LSP is reporting the error
  },
})
