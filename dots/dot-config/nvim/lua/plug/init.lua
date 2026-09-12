local config_dir = vim.fn.stdpath("config")
local plug_dir = config_dir .. "/lua/plug"

for path in vim.fn.glob(plug_dir .. "/**/*.lua"):gmatch("[^%s]+") do
    local relpath = path:sub(#plug_dir + 2)
    local module_name = relpath:gsub("%.lua$", ""):gsub("/", ".")
    if module_name ~= "init" then
        require("plug." .. module_name)
    end
end
