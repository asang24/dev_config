local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- 保存此文件自动更新安装软件
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- plugins here

    -- 主题
    use 'ellisonleao/gruvbox.nvim'

    -- vs-code like icons
    -- lualine 和nvim-tree 依赖此插件
    use("nvim-tree/nvim-web-devicons")

    -- commenting with gc
    -- 快捷键gcc 注释单行
    -- 比如注释3行, gc3j
    use("numToStr/Comment.nvim")

    -- 状态栏
    use("nvim-lualine/lualine.nvim")

    -- 文档树
    use("nvim-tree/nvim-tree.lua")

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
        use 'nvim-treesitter/nvim-treesitter-context'
    })

    use "p00f/nvim-ts-rainbow" -- 配合treesitter，不同括号颜色区分
    use "christoomey/vim-tmux-navigator" -- 用ctl-hjkl来定位窗口  

    -- autocompletion
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path") -- source for file system paths

    -- snippets
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("saadparwaiz1/cmp_luasnip") -- for autocompletion
    use("rafamadriz/friendly-snippets") -- useful snippets

    -- lsp
    use {
        "williamboman/mason.nvim", -- managing & installing lsp servers
        "williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁

        "neovim/nvim-lspconfig", -- easily configure language servers
        "hrsh7th/cmp-nvim-lsp", -- for autocompletion
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lsp-signature-help"
    }

    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require("lspsaga").setup({})
        end,
        requires = {
            {"nvim-tree/nvim-web-devicons"},
            --Please make sure you install markdown and markdown_inline parser
            {"nvim-treesitter/nvim-treesitter"}
        }
    })
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

    -- file telescope
    use 'BurntSushi/ripgrep'
    -- 文件检索 
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',  -- 文件检索
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance

    -- auto closing
    use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags


    -- git integration
    use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side  
    use "akinsho/bufferline.nvim" -- buffer分割线 

    -- floating terminal
    use 'akinsho/toggleterm.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)


