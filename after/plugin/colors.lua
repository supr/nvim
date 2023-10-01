require("onedark").setup({
    style = 'darker',
    transparent = true,
    lualine = {
        transparent = true,
    },
})

require("onedark").load()

function ColorMyPensils(color)
    color = color or "onedark"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLineSelect", { bg = "none" })

end

ColorMyPensils("kanagawa-wave")

-- vim.cmd.colorscheme("kanagawa-wave")
