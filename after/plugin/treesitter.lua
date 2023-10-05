require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "cpp", "lua", "rust", "go", "python", "vim", "bash", "comment", "soql", "sosl", "vim", "vimdoc", "yaml", "jsonc" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        select = {
            enable = true,

            lookahead = true,

            keymaps = {
                ["of"] = "@function.outer",
                ["if"] = "@function.inner",
            },

            selection_modes = {
                ['@parameter.outer'] = 'v',
                ['@function.outer'] = 'V',
                ['@class.outer'] = '<C-V>',
            },

            including_surrounding_whitespace = true,
        },
    },
})

require('treesitter-context').setup({
    enable = true,
    max_lines = 0,
    min_window_height = 0,
    line_numbers = true,
    trim_scope = 'outer',
    mode = 'cursor',
    separator = nil,
    zindex = 20,
    on_attach = nil,
})
