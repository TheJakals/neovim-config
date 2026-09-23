local map = vim.keymap.set

-- Accept completion with Shift+Tab (first item if none selected)
map("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 0 then
    return "<S-Tab>"
  end
  return vim.fn.complete_info({ "selected" }).selected == -1 and "<C-n><C-y>" or "<C-y>"
end, { expr = true, desc = "Accept completion" })

-- Manually trigger completion
map("i", "<S-Space>", "<C-x><C-o>", { desc = "Trigger completion" })

local function indent_aware(key)
  return function()
    -- Skip with a count (3i would become 3"_cc) and in terminal/special buffers
    if vim.v.count == 0 and vim.bo.modifiable and vim.bo.buftype == ""
      and vim.api.nvim_get_current_line():match("^%s*$") then
      return '"_cc'
    end
    return key
  end
end

vim.keymap.set("n", "i", indent_aware("i"), { expr = true, desc = "Indent-aware insert" })
vim.keymap.set("n", "a", indent_aware("a"), { expr = true, desc = "Indent-aware append" })
