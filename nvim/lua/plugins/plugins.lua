local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
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

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    -- plugins here

    -- 主题
    use("ellisonleao/gruvbox.nvim")

    -- vs-code like icons
    -- lualine 和nvim-tree 依赖此插件
    use("nvim-tree/nvim-web-devicons")

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
        use("nvim-treesitter/nvim-treesitter-context"),
    })

    use("p00f/nvim-ts-rainbow")           -- 配合treesitter，不同括号颜色区分
    use("christoomey/vim-tmux-navigator") -- 用ctl-hjkl来定位窗口
    use("xiyaowong/nvim-transparent")     -- nvim背景透明


    -- coc 补全
    use({ "neoclide/coc.nvim", branch = "release" })

    -- file telescope
    use("BurntSushi/ripgrep")
    -- 文件检索
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1", -- 文件检索
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance

    -- floating terminal
    use("akinsho/toggleterm.nvim")

    use("github/copilot.vim")

    ---------------  go --------------------
    use("crispgm/nvim-go")

    use("gelguy/wilder.nvim")

    -- signcolumn显示折叠信息
    use { 'yaocccc/nvim-foldsign', event = 'CursorHold', config = 'require("nvim-foldsign").setup()' }
    -- 注释插件
    use { 'yaocccc/vim-comment', cmd = '*ToggleComment' }

    use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
