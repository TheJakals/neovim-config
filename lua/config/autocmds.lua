local autocmd = vim.api.nvim_create_autocmd

-- Auto format on save
autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  callback = function() vim.cmd("%s/\\s\\+$//e") end,
})

-- Register .templ filetype
vim.filetype.add({ extension = { templ = "templ" } })

-- Transparent background after colorscheme loads
autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
  end,
})

autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "telescope-fzf-native.nvim" then
      vim.system({ "make" }, { cwd = ev.data.path })
    end
  end,
})


-- Disable autocomplete in Telescope
autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.opt_local.autocomplete = false
  end,
})

-- Trigger completion after dot
autocmd("TextChangedI", {
  callback = function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local char = line:sub(col, col)
    if char == "." then
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true),
        "n",
        false
      )
    end
  end,
})


