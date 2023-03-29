local opt = vim.opt

-- 行号
-- opt.relativenumber = true
opt.number = true

-- 设置无操作时,交换文件写入磁盘的等待时间
opt.updatetime = 60

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
-- 防止包裹
opt.wrap = false

-- 光标行
opt.cursorline = true

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard = "unnamed"

-- 搜索
opt.ignorecase = true
opt.smartcase= true
-- Enable highlight on sear
opt.hlsearch = true
opt.incsearch = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"

-- utf-8
vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- Incremental live completion
opt.inccommand = "nosplit"

-- Enable break indent
opt.breakindent = true

opt.swapfile = false

-- Folding
opt.foldenable = true

-- Use ripgrep as grep tool
opt.grepprg = "rg --vimgrep --no-heading"
opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"

