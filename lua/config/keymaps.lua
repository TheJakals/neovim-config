local map = vim.keymap.set

-- Accept first completion suggestion with Shift+Space
map("i", "<S-Tab>", function()
  local pumvisible = vim.fn.pumvisible() == 1
  if pumvisible then
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<C-n><C-y>", true, false, true),
      "n",
      false
    )
  else
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true),
      "n",
      false
    )
  end
end, { desc = "Accept first completion" })
