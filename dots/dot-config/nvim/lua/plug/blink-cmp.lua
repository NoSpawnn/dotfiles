vim.pack.add({
    { src = 'https://github.com/Saghen/blink.cmp', version = vim.version.range('v1.*') },
    'https://github.com/saghen/blink.lib'
})

---@module 'blink.cmp'
---@type blink.cmp.Config
local blink_config = {
    keymap = { preset = 'default' },
    completion = {
        menu = { border = 'rounded' },
        documentation = { auto_show = false },
    }
}

require("blink.cmp").setup(blink_config)
