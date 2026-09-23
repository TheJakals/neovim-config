local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank() end,
})

-- Remove trailing whitespace on save (keeps cursor in place; markdown uses trailing spaces as line breaks)
autocmd("BufWritePre", {
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype
    if ft == "markdown" or ft == "diff" then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

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

-- Plugin build steps (must be defined before vim.pack.add)
autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    end
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
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

-- Avoid dbext-dependent SQL omnifunc error
autocmd("FileType", {
  pattern = "sql",
  callback = function()
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})
