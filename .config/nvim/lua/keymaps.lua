local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

local NORMAL_MODE = "n"
local INSERT_MODE = "i"
local VISUAL_MODE = "v"
local VISUAL_BLOCK_MODE = "x"

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Buffer Navigation
keymap(INSERT_MODE, "<C-h>", "<Left>", opts)
keymap(INSERT_MODE, "<C-j>", "<Down>", opts)
keymap(INSERT_MODE, "<C-k>", "<Up>", opts)
keymap(INSERT_MODE, "<C-l>", "<Right>", opts)
keymap(NORMAL_MODE, "<C-i>", "<C-I>", opts)

-- Windows navigation
keymap(NORMAL_MODE, "<C-h>", "<C-w>h", opts)
keymap(NORMAL_MODE, "<C-j>", "<C-w>j", opts)
keymap(NORMAL_MODE, "<C-k>", "<C-w>k", opts)
keymap(NORMAL_MODE, "<C-l>", "<C-w>l", opts)

-- Open directory listing
keymap(NORMAL_MODE, "<leader>e", ":Lex 30<CR>", opts)

-- Remove search highlighting when pressing ESC in normal mode
keymap(NORMAL_MODE, "<ESC>", ":noh <CR>", opts)

-- Press "jk" to get back to normal mode
keymap(INSERT_MODE, "jk", "<ESC>", opts)

-- Moving text/blocks maps
keymap(VISUAL_MODE, "<A-j>", ":m .+1<CR>==V", opts)
keymap(VISUAL_MODE, "<A-k>", ":m .-2<CR>==V", opts)
keymap(NORMAL_MODE, "<A-j>", ":m .+1<CR>==", opts)
keymap(NORMAL_MODE, "<A-k>", ":m .-2<CR>==", opts)
keymap(VISUAL_BLOCK_MODE, "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap(VISUAL_BLOCK_MODE, "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Telescope related
keymap(NORMAL_MODE, "<leader>f", "<cmd>lua require'telescope.builtin'.find_files({find_command = { 'rg', '--files', '--glob', '!.git/', '--glob', '!.bak/', '--hidden' },})<CR>", opts)
keymap(NORMAL_MODE, "<leader>/", "<cmd>Telescope live_grep<CR>", opts)
keymap(NORMAL_MODE, "<leader>g", "<cmd> Telescope git_files<CR>", opts)

-- Harpoon related
keymap(NORMAL_MODE, "<leader>a", "<cmd>lua mark.add_file()<CR>", opts)
keymap(NORMAL_MODE, "<C-e>", "<cmd>lua ui.toggle_quick_menu()<CR>", opts)

keymap(NORMAL_MODE, "<A-a>", "<cmd>lua ui.nav_file(1)<CR>" , opts)
keymap(NORMAL_MODE, "<A-s>", "<cmd>lua ui.nav_file(2)<CR>", opts)
keymap(NORMAL_MODE, "<A-d>", "<cmd>lua ui.nav_file(3)<CR>" , opts)
keymap(NORMAL_MODE, "<A-f>", "<cmd>lua ui.nav_file(4)<CR>", opts)
keymap(NORMAL_MODE, "<A-j>", "<cmd>lua ui.nav_next()<CR>", opts)
keymap(NORMAL_MODE, "<A-k>", "<cmd>lua ui.nav_prev()<CR>", opts)

-- Rust related
keymap(NORMAL_MODE, "<C-t>r", ":FloatermNew --autoclose=0 cargo run<CR>", opts)
keymap(NORMAL_MODE, "<C-t>d", ":FloatermNew --autoclose=0 RUST_BACKTRACE=1 cargo run<CR>", opts)
keymap(NORMAL_MODE, "<C-t>b", ":FloatermNew --autoclose=0 cargo build<CR>", opts)
keymap(NORMAL_MODE, "<C-t>c", ":FloatermNew --autoclose=0 cargo check<CR>", opts)
