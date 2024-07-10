require("jimit.set")
require("jimit.remap")
require("jimit.lazy-init")

print("Hello from jimit")

function ColorMyPencils()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
