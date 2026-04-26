return {
	-- Autocomments
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end
	},

	-- Theme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme rose-pine-main")
		end
	},

	-- LSP
	{
		"williamboman/mason.nvim",
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets',

			'hrsh7th/cmp-nvim-lsp',

		},
	},

	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
	},

	-- Telescope
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},

	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
	},

	-- Neodev (to help building neovim packages)
	'folke/neodev.nvim',

	-- Keybinds cheatsheet
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
			},
		},
	},

	-- Autopairing of (), [], {}
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},

	-- Indentation markers
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},

	-- Harpoon yaaaaay
	"ThePrimeagen/harpoon",

	-- Hexadecimal colorizer
	"catgoose/nvim-colorizer.lua",

	-- TODO/FIXME and stuff.
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},

	-- Fidget for LSP progress stuff
	{
		"j-hui/fidget.nvim",
	},

	-- Rust related stuff
	{
		'mrcjkb/rustaceanvim',
		version = '^6', -- Recommended
		lazy = false, -- This plugin is already lazy
	},

	-- Floating terminals embedded in neovim
	{
		'voldikss/vim-floaterm'
	}
}
