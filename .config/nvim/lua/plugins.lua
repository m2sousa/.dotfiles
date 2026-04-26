local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins_list")

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
})

require('fidget').setup()

-- Rustacean configuration
vim.g.rustaceanvim = {
    tools = {},
    -- LSP configuration
    server = {
        on_attach = function(_, bufnr)
            -- Enable inlay hints by default when LSP attaches
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            
            local bufmap = function(keys, func)
                vim.keymap.set('n', keys, func, { buffer = bufnr })
            end
            bufmap('<leader>r', vim.lsp.buf.rename)
            bufmap('<leader>ca', vim.lsp.buf.code_action)
			bufmap('gd', function()
				vim.lsp.buf.definition({
					on_list = function(options)
						if #options.items == 1 then
							-- Single location: jump directly
							local item = options.items[1]
							vim.cmd('edit ' .. vim.fn.fnameescape(item.filename))
							vim.api.nvim_win_set_cursor(0, {item.lnum, item.col - 1})
						else
							-- Multiple locations: check if they're equivalent
							local first = options.items[1]
							local all_same = true

							for i = 2, #options.items do
								local current = options.items[i]
								if current.filename ~= first.filename or 
									current.lnum ~= first.lnum or 
									current.col ~= first.col then
									all_same = false
									break
								end
							end

							if all_same then
								-- All entries point to same location: jump directly
								vim.cmd('edit ' .. vim.fn.fnameescape(first.filename))
								vim.api.nvim_win_set_cursor(0, {first.lnum, first.col - 1})
							else
								-- Multiple different locations: show quickfix list
								vim.fn.setqflist({}, ' ', options)
								vim.cmd('copen')
							end
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
            
            -- Toggle inlay hints
            bufmap('<leader>ih', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            end)
            
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, {})

			-- Rustfmt
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})

		end,
        default_settings = {
            ['rust-analyzer'] = {
				assist = {
					preferSelf = true,
				},
				cachePriming = {
					-- This means that all of the project will be cached once a file is opened.
					-- It could be disabled for very large project to speed up the lsp start-up.
					enable = true,
				},
				completion = {
					fullFunctionSignatures = { enable = true },
				},
				diagnostics = {
					styleLints = { enable = true },
				},
				highlightRelated = {
					branchExitPoints = { enable = true },
					breakPoints = { enable = true },
					closureCaptures = { enable = true },
					exitPoints = { enable = true },
					references = { enable = true },
				},
				hover = {
					actions = { enable = true },
					maxSubstitutionLength = 50,
				},
                inlayHints = {
                    enable = true,
					bindingModeHints = { enable = true },
                    typeHints = {
						enable = true,
						hideNamedConstructor = true,
					},
                    parameterHints = { enable = true, },
                    chainingHints = { enable = true, },
					closingBraceHints = {
						enable = true,
						minLines = 20,
					},
					closureCapturesHints = {
						enable = true,
					},
					genericParameterHints = {
						lifetime = { enable = false },
					},
                },
            },
        },
    },
    dap = {},
}
