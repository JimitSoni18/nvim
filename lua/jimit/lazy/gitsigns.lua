return {
	'lewis6991/gitsigns.nvim',
	config = function()
		local gitsigns = require('gitsigns')
		gitsigns.setup({
			on_attach = function ()
				vim.keymap.set('n', ']g', function()
					gitsigns.nav_hunk('next')
				end)
				vim.keymap.set('n', '[g', function()
					gitsigns.nav_hunk('prev')
				end)
			end
		})
	end,
	event = 'BufEnter'
}
