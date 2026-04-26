-- LSP on_attach function
local on_attach = function(_, bufnr)
    local bufmap = function(keys, func)
        vim.keymap.set('n', keys, func, { buffer = bufnr })
    end
    
    bufmap('<leader>r', vim.lsp.buf.rename)
    bufmap('<leader>ca', vim.lsp.buf.code_action)
	bufmap('gd', function()
		vim.lsp.buf.definition({
			on_list = function(options)
				if #options.items == 1 then
					-- Single location: jump directly using proper LSP utilities
					local item = options.items[1]
					vim.cmd('edit ' .. vim.fn.fnameescape(item.filename))
					vim.api.nvim_win_set_cursor(0, {item.lnum, item.col - 1})
				else
					-- Multiple locations: show quickfix
					vim.fn.setqflist({}, ' ', options)
					vim.cmd('cfirst')
				end
			end
		})
	end)
    bufmap('gD', vim.lsp.buf.declaration)
    bufmap('gI', vim.lsp.buf.implementation)
    bufmap('<leader>D', vim.lsp.buf.type_definition)
    bufmap('gr', require('telescope.builtin').lsp_references)
    bufmap('gs', require('telescope.builtin').lsp_document_symbols)
    bufmap('gS', require('telescope.builtin').lsp_dynamic_workspace_symbols)
    bufmap('K', vim.lsp.buf.hover)
    
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {})
end
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
	function(server_name)
		require("lspconfig")[server_name].setup {
			on_attach = on_attach,
			capabilities = capabilities
		}
	end,

	["lua_ls"] = function()
		require('neodev').setup()
		require('lspconfig').lua_ls.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			}
		}
	end,
})

-- Inline lsp diagnostics
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
  signs = true,
  underline = true,
  severity_sort = true,
})
