-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

-- enable mason
mason.setup({
  ui = {
    icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
    }
  }
})


-- 支持的语言参考 https://github.com/williamboman/mason-lspconfig.nvim#automatic-server-setup-advanced-feature
mason_lspconfig.setup({
  -- list of servers for mason to install
  ensure_installed = {
    "bashls",           -- bash
    "gopls",            -- go
    "jsonls",           -- json
    "lua_ls",           -- lua
    "sqls",             -- sql
    "yamlls"            -- yaml    
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true, -- not the same as ensure_installed
})

