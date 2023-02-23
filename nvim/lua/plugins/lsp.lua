return {
	'hrsh7th/cmp-nvim-lsp',
	dependencies = { "neovim/nvim-lspconfig", 'jose-elias-alvarez/typescript.nvim' },
	config = function()
		local lspconfig_status, lspconfig = pcall(require, "lspconfig")
		if not lspconfig_status then
			return
		end

		local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if not cmp_nvim_lsp_status then
			return
		end

		local typescript_setup, typescript = pcall(require, "typescript")
		if not typescript_setup then
			return
		end

		local keymap = vim.keymap -- for conciseness
		local opts = { noremap = true, silent = true }

		keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
		keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

		local on_attach = function(_, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', bufopts)
			vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, bufopts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
			vim.keymap.set('n', '<leader>d', '<cmd>Telescope lsp_document_symbols<cr>', bufopts)

			-- format on save
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end
			})
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		keymap.set('n', '<leader>o', '<cmd>TypescriptOrganizeImports<cr>')
		keymap.set('n', '<leader>a', '<cmd>TypescriptAddMissingImports<cr>')
		keymap.set('n', '<leader>r', '<cmd>TypescriptRemoveUnused<cr>')

		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure typescript server with plugin
		typescript.setup({
			server = {
				capabilities = capabilities,
				on_attach = on_attach,
				init_options = {
					preferences = {
						importModuleSpecifierPreference = "project=relative",
						jsxAttributeCompletionStylr = 'none'
					},
				},
			},
		})
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure tailwindcss server
		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure emmet language server
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- configure eslint server
		lspconfig["eslint"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end
}
