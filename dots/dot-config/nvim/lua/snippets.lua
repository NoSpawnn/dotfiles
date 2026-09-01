-- global abbreviations
for name, body in pairs({
    lgtm = "looks good to me",
}) do
    vim.cmd.iabbrev(name, body)
end

-- language/buffer specific abbreviations
for ft, abbrs in pairs({
    -- table of <lang> = [ <abbr> = <str> ]
    lua = {
        req = 'require("").setup({})<ESC>2F(la',
        kms = 'vim.keymap.set("", "", , {})<ESC>F(la',
    },
    cpp = {
        fmain = "int main() {<CR>}<ESC>Oreturn;<ESC>hi",
    },
}) do
    for name, body in pairs(abbrs) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = ft,
            callback = function()
                vim.cmd.inoreabbrev("<buffer> " .. name, body)
            end,
        })
    end
end
