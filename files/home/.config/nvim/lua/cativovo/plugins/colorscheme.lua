return {
    'catppuccin/nvim',
    name = 'catppuccin',
    commit = '931a129463ca09c8805d564a28b3d0090e536e1d',
    opts = {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = {
            light = 'latte',
            dark = 'mocha',
        },
        float = {
            transparent = true,
        },
        transparent_background = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            telescope = true,
            mason = true,
            flash = true,
            fidget = true,
        },
    },
    transparent_background = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        mason = true,
        flash = true,
        fidget = true,
    },
    init = function()
        vim.cmd.colorscheme('catppuccin')
    end,
}
