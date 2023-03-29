local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
            'interface',
            'struct',
            'enum',
        },
        -- Patterns for specific filetypes
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        tex = {
            'chapter',
            'section',
            'subsection',
            'subsubsection',
        },
        haskell = {
            'adt'
        },
        rust = {
            'impl_item',

        },
        terraform = {
            'block',
            'object_elem',
            'attribute',
        },
        scala = {
            'object_definition',
        },
        vhdl = {
            'process_statement',
            'architecture_body',
            'entity_declaration',
        },
        markdown = {
            'section',
        },
        elixir = {
            'anonymous_function',
            'arguments',
            'block',
            'do_block',
            'list',
            'map',
            'tuple',
            'quoted_content',
        },
        json = {
            'pair',
        },
        typescript = {
            'export_statement',
        },
        yaml = {
            'block_mapping_pair',
        },
    },
    exact_patterns = {
    },

    zindex = 20, -- The Z-index of the context window
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
}

treesitter.setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- disable standard vim highlighting
    },
    indent = { enable = true },
    autotag = { enable = true },
    context_commentstring = {enable = true, enable_autocmd = false},

    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"}
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer"
        }
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
    },
    textobjects = {
        select = {
            enable = false,
            lookahead = true,
        },
    },
    sync_install = true,
    -- for installing specific parsers

    ensure_installed = {
        "vim",
        "bash",
        "lua",
        "go",
        "json"
    },
    --启用增量选择
    incremental_selection = {
        enable = true,
    },

    -- 不同括号颜色区分
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
})
-- 开启代码折叠
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不折叠
vim.wo.foldlevel = 99

local auto_indent = vim.api.nvim_create_augroup("AUTO_INDENT", {clear = true})
vim.api.nvim_create_autocmd({"BufWritePost"}, {
    pattern = "*",
    group = auto_indent,
    command = 'normal! fm=G``'
})
