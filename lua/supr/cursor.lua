local api = vim.api

local restoreCursorShapeOnExitGroup = api.nvim_create_augroup("RestoreCursorShapeOnExit", { clear = true })
api.nvim_create_autocmd("VimLeave", {
  command = "set guicursor=a:ver20",
  group = restoreCursorShapeOnExit,
})
