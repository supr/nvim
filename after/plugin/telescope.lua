require('telescope').setup({
    defaults = {
        pickers = {
            find_command = {
                "fdx"
            },
        },
    },
    extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
    }
})

require("telescope").load_extension('fzf')

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<leader><leader>", builtin.buffers, {})
vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
