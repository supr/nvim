require('lualine').setup({
    options = {
        theme = 'onedark'
    },
    tabline = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'tabs'},
    },
    extensions = {'fzf', 'quickfix'},
})
