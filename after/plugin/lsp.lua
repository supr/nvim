vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f1f28]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=#dcd7ba guibg=#1f1f28]]

local border = {
      {"🭽", "FloatBorder"},
      {"▔", "FloatBorder"},
      {"🭾", "FloatBorder"},
      {"▕", "FloatBorder"},
      {"🭿", "FloatBorder"},
      {"▁", "FloatBorder"},
      {"🭼", "FloatBorder"},
      {"▏", "FloatBorder"},
}

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border}),
}
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
    },
    {
        { name = 'buffer' },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            before = function(entry, vim_item)
                return vim_item
            end
        })
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
    local lsp_stat = require('lsp-status')
    lsp_stat.on_attach(client)

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', bufopts)
    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', bufopts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
    end

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        sevierty_sort = false,
    })
end

local lsp_status = require('lsp-status')
lsp_status.register_progress()

require("lspconfig").rust_analyzer.setup({
    settings = {
        ['rust-analyzer'] = {
            diagnostic = {
                enabled = true,
            }
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
})

require("lspconfig").pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    maxLineLength = 120
                }
            }
        }
    },
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
})

require('fidget').setup({})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
