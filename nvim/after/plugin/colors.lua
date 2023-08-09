-- Function to detect the system theme and adjust NeoVim theme accordingly
local function set_theme_based_on_os()
    local opts = {}

    local isDarkMode = vim.fn.system("osascript -e 'tell app \"System Events\" to tell appearance preferences to return dark mode'")

    if isDarkMode == "true\n" then
        opts.background = "dark"
        opts.flavour = "mocha"
    elseif isDarkMode == "false\n" then
        opts.background = "tokyonight light"
        opts.flavour = "latte"
    else
        error("expected isDarkMode to be \"true\\n\" or \"false\\n\",  but isDarkMode is " .. isDarkMode)
    end

    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
end

set_theme_based_on_os()

