local options = {
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 2,
	conceallevel = 0,
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true,
	showmode = false,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	timeoutlen = 1000,
	undofile = true,
	updatetime = 300,
	writebackup = false,
	cursorline = true,
	number = true,
	relativenumber = true,
	numberwidth = 2,
	signcolumn = "yes",
	scrolloff = 8,
	sidescrolloff = 8,
	shiftwidth = 4,
	softtabstop = 4,
	tabstop = 4,
	mouse = "",
}

for key, value in pairs(options) do
	vim.opt[key] = value
end
