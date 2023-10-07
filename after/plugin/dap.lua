local dap = require("dap")

local codelldb_root = "/home/p/root/usr/lib/codelldb/"
local codelldb_path = codelldb_root .. "adapter/codelldb"
local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

dap.defaults.fallback.exception_breakpoints = { 'all' }

dap.adapters.lldb = {
    type = "executable",
    command = codelldb_path,
    name = "lldb",
    args = { "--liblldb", liblldb_path, "--port", "0" },
}

--[[ dap.adapters.cpp = {
    type = "server",
    port = "${port}",
    host = "127.0.0.1",
    executable = {
        command = codelldb_path,
        args = { "--liblldb", liblldb_path, "--port", "${port}" },
    },
} ]]

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.keymap.set("n", "<F1>", dap.step_into)
vim.keymap.set("n", "<F2>", dap.step_over)
vim.keymap.set("n", "<F3>", dap.step_out)
vim.keymap.set("n", "<F4>", dap.continue)

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>cb", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
end)

vim.keymap.set("n", "<leader>lb", function()
    dap.list_breakpoints()
    vim.cmd.copen()
end, { desc = "List breakpoints in quickfix list" })

vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='🔵', texthl='', linehl='', numhl=''})

local widgets = require("dap.ui.widgets")
vim.keymap.set("n", "<leader>i", widgets.hover, {desc = "DAP Inspect"})

require("nvim-dap-virtual-text").setup()

require("dapui").setup({ mappings = { remove = "b" } })

dap.listeners.after.event_initialized["dapui_config"] = function()
    require("dapui").open()
end

vim.keymap.set("n", "<leader>dui", require("dapui").toggle, { desc = "Toggle dapui" })
vim.keymap.set("n", "<leader>cdb", function()
    dap.terminate()
    require("dapui").close()
end)
