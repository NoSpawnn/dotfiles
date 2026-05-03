return {
    "nvim-mini/mini.surround",
    keys = {
        { "sa", "lua require('mini.surround').add()",     desc = "Add surround" },
        { "sd", "lua require('mini.surround').delete()",  desc = "Delete surround" },
        { "sr", "lua require('mini.surround').replace()", desc = "Replace surround" },
    },
    opts = {}
}
