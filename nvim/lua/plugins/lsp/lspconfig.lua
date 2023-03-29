-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local keymap = vim.keymap -- for conciseness

local on_attach = function(_,bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  ---------------- set keybinds  --------------------

   -- show definition, references
   keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>",opts)

   -- Code action
   keymap.set({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>",opts)

   -- Rename all occurrences of the hovered word for the entire file
   keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>",opts)

   -- Peek definition  
    keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>",opts) -- 悬浮窗 查看代码实现
    keymap.set("n","gd", "<cmd>Lspsaga goto_definition<CR>",opts)  -- 进入代码实现
    keymap.set("n", "ld", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation

    -- type definition
    keymap.set("n", "pt", "<cmd>Lspsaga peek_type_definition<CR>",opts)
    keymap.set("n","gt", "<cmd>Lspsaga goto_type_definition<CR>",opts)

    -- Show diagnostics
    keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>",opts)
    keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>",opts)
    keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>",opts)

    -- Diagnostic jump
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>",opts)
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>",opts)

    -- 查看注释文档
    keymap.set("n", "hd", "<cmd>Lspsaga hover_doc<CR>",opts)
    -- Toggle outline
    keymap.set("n","<leader>so", "<cmd>Lspsaga outline<CR>",opts)

end

-- used to enable autocompletio (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

-- -------------------- general settings -- --------------------
vim.fn.sign_define("DiagnosticSignError", {
    texthl = "DiagnosticSignError",
    text = " ✗",
    numhl = "DiagnosticSignError",
})
vim.fn.sign_define("DiagnosticSignWarn", {
    texthl = "DiagnosticSignWarn",
    text = " ❢",
    numhl = "DiagnosticSignWarn",
})
vim.fn.sign_define("DiagnosticSignHint", {
    texthl = "DiagnosticSignHint",
    text = " ",
    numhl = "DiagnosticSignHint",
})
vim.fn.sign_define("DiagnosticSignInfo", {
    texthl = "DiagnosticSignInfo",
    text = " 𝓲",
    numhl = "DiagnosticSignInfo",
})
vim.diagnostic.config({
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    virtual_text = true,
})

-- -------------------- go lsp settings -- --------------------
lspconfig["gopls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
    -- init_options = {usePlaceholders = true, completeUnimported = true},
    settings = {
        gopls = {
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
})

lspconfig["bashls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig["jsonls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig["yamlls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { -- custom settings for lua
        Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- make language server aware of runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})

