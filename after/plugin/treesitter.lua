require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "cpp", "lua", "rust", "go", "python", "vim", "bash", "comment", "soql", "sosl", "vim", "vimdoc", "yaml", "jsonc" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

