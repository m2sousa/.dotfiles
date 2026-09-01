vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.h" },
  callback = function()
    local clients = vim.lsp.get_clients({ bufnr = 0, name = "clangd" })

    if #clients > 0 then
      vim.lsp.buf.format({ async = false })
    else
      vim.cmd("silent! %!clang-format")
    end
  end,
})
