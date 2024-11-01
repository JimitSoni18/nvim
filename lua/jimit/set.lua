-- 14rnu
vim.opt.nu = true
vim.opt.rnu = true

-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.smartindent = true

-- undo
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search and highlight
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.updatetime = 600
vim.opt.incsearch = true

-- colors
vim.opt.termguicolors = true

-- scrolloff
vim.opt.scrolloff = 5

-- column
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

local theme_change = vim.api.nvim_create_augroup('theme_change', {})

RemoveBg = function()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end


-- vim.api.nvim_create_autocmd('ColorScheme', {
-- 	group = theme_change,
-- 	callback = remove_bg
-- })

local vim_enter = vim.api.nvim_create_augroup('vim_enter', {})

vim.api.nvim_create_autocmd('VimEnter', {
	group = vim_enter,
	callback = function()
		local cwd = vim.fn.getcwd()
		local init = cwd .. "/.nvim/init.lua"
		local stat = vim.loop.fs_stat(init)
		if stat and stat.type == 'file' then
			vim.cmd("so " .. init)
		end
	end
})
