local jimit = vim.api.nvim_create_augroup('jimit', {})

vim.api.nvim_create_autocmd('LspAttach', {
	group = jimit,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>h", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, opts)
		-- what is this
		-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

		local function safe_document_highlight()
			local clients = vim.lsp.get_active_clients({ bufnr = 0 })
			local has_capable_client = false

			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					has_capable_client = true
					break
				end
			end

			if has_capable_client then
				vim.lsp.buf.document_highlight()
				-- local status, error = pcall(vim.lsp.buf.document_highlight)
				-- if not status then
				-- 	print("Failed to highlight: " .. error)
				-- end
			end
		end

		vim.api.nvim_create_autocmd('CursorHold', {
			group = jimit,
			callback = safe_document_highlight
		})

		vim.api.nvim_create_autocmd('CursorHoldI', {
			group = jimit,
			callback = safe_document_highlight
		})

		vim.api.nvim_create_autocmd('CursorMoved', {
			group = jimit,
			callback = vim.lsp.buf.clear_references
		})
	end
})

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local lsp_config = require("lspconfig")
		lsp_config.rust_analyzer.setup({
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy"
					}
				}
			}
		})
		lsp_config.slint_lsp.setup({})
		lsp_config.clangd.setup({})
		lsp_config.lua_ls.setup({})
		lsp_config.gopls.setup({})
		lsp_config.tsserver.setup({})
		lsp_config.eslint.setup({})
		lsp_config.astro.setup({})
		lsp_config.tailwindcss.setup({})
		local cmp = require('cmp')
		-- local cmp_lsp = require("cmp_nvim_lsp")
		-- local capabilities = vim.tbl_deep_extend(
		-- 	"force",
		-- 	{},
		-- 	vim.lsp.protocol.make_client_capabilities(),
		-- 	cmp_lsp.default_capabilities()
		-- )

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
				['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				['<CR>'] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
			}, {
				{ name = 'buffer' },
			})
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end
}
