vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
})

function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require("oil").get_current_dir(bufnr)

    if dir then -- show dir path, without trailing slash
        local res = vim.fn.fnamemodify(dir, ":~")
        return res:sub(-1) == "/" and res:sub(1, -2) or res
    else -- show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

require("oil").setup({
    watch_for_changes = true,
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    constrain_cursor = false,

    win_options = { winbar = "%!v:lua.get_oil_winbar()" },
    columns = { "icon", "permissions", "size", "mtime" },
})
