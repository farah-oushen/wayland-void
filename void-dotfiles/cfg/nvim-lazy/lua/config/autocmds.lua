-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here---@diagnostic disable: param-type-mismatch
------------------------------------------------
-- Disable autoformat for some buffers:
------------------------------------------------
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "bash", "sh" },
  callback = function()
    vim.b.autoformat = false
  end,
})
------------------------------------------------
-- Disable the concealing in some file formats
------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})
------------------------------------------------
-- Disable AutoComment:
------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  desc = "remove formatoptions",
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
})
------------------------------------------------
-- Open Dashboard after deleting the last buffer (Uses bufdelete plugin)
------------------------------------------------
-- Open Dashboard after deleting the last buffer (Uses bufdelete plugin)
vim.api.nvim_create_augroup("dashboard_on_empty", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "BDeletePre *",
  group = "dashboard_on_empty",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)

    if name == "" then
      local current_win = vim.api.nvim_get_current_win()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if win ~= current_win then
          vim.api.nvim_win_close(win, false)
        end
      end

      local current_tab = vim.api.nvim_get_current_tabpage()
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        if tab ~= current_tab then
          vim.api.nvim_tabpage_close(tab, false)
        end
      end

      vim.cmd.Dashboard()
    end
  end,
})
