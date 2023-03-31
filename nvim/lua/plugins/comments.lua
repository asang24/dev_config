vim.g.vim_line_comments = {
    vim = '"',
    vimrc = '"',
    go = '//',
    ['go.mod'] = '//',
    lua = '--',
    sql = '--',
}

vim.g.vim_chunk_comments = {
    sh = { ':<<!', '', '!' },
    md = { '[^_^]:', '    ', '' },
}

local keyset = vim.keymap.set

keyset('n', '<C-/>', ':NToggleComment<cr>', { silent = true, noremap = true })
keyset('v', '<C-/>', ':<c-u>VToggleComment<cr>', { silent = true, noremap = true })
keyset('v', '?', ':<c-u>CToggleComment<cr>', { silent = true, noremap = true })
