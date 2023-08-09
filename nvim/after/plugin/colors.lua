-- Function to detect the system theme and adjust NeoVim theme accordingly
local function set_theme_based_on_os()
    local isDarkMode = vim.fn.system("osascript -e 'tell app \"System Events\" to tell appearance preferences to return dark mode'")

    if isDarkMode == "true\n" then
        require("catppuccin").setup({
            flavour = "mocha",
            background = "dark",
        })
        vim.cmd.colorscheme("catppuccin")

    elseif isDarkMode == "false\n" then
        print("HERE")
        require("tokyonight").setup({
            style = "day",
            styles = {
                keywords = { italic = false },
            }
        })
        vim.cmd.colorscheme("tokyonight")

    else
        error("expected isDarkMode to be \"true\\n\" or \"false\\n\",  but isDarkMode is " .. isDarkMode)
    end
end

set_theme_based_on_os()

