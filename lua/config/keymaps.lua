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

-- Manually trigger completion
map("i", "<S-Space>", "<C-x><C-o>", { desc = "Trigger completion" })

local function indent_aware(key)
  return function()
    if vim.api.nvim_get_current_line():match("^%s*$") then
      return '"_cc'
    end
    return key
  end
end

vim.keymap.set("n", "i", indent_aware("i"), { expr = true, desc = "Indent-aware insert" })
vim.keymap.set("n", "a", indent_aware("a"), { expr = true, desc = "Indent-aware append" })
