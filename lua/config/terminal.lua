-- Quick terminal at the bottom of the screen.
-- <leader>t toggles it from normal mode, <C-/> hides it from inside the terminal.
-- The shell keeps running while hidden; type `exit` to close it for good.
local term_buf = nil

local function toggle_terminal()
  local has_term = term_buf ~= nil and vim.api.nvim_buf_is_valid(term_buf)

  -- Visible in this tab: hide it
  if has_term then
    local wins = vim.tbl_filter(function(win)
      return vim.api.nvim_win_get_buf(win) == term_buf
    end, vim.api.nvim_tabpage_list_wins(0))
    if #wins > 0 then
      for _, win in ipairs(wins) do
        pcall(vim.api.nvim_win_hide, win) -- fails only if it is the last window
      end
      return
    end
  end

  vim.cmd("botright 15split")
  if has_term then
    vim.api.nvim_win_set_buf(0, term_buf)
  else
    vim.cmd.terminal()
    term_buf = vim.api.nvim_get_current_buf()
    vim.bo[term_buf].buflisted = false
    -- Terminals send Ctrl+/ as either <C-/> or <C-_>
    for _, key in ipairs({ "<C-/>", "<C-_>" }) do
      vim.keymap.set("t", key, toggle_terminal, { buffer = term_buf, desc = "Hide terminal" })
    end
  end
  vim.wo.winfixheight = true
  vim.cmd.startinsert()
end

vim.keymap.set("n", "<leader>t", toggle_terminal, { desc = "Toggle terminal" })
