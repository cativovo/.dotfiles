local M = {}

local _maximized = nil
M.maximize = function(state)
    if state == (_maximized ~= nil) then
        return
    end
    if _maximized then
        for _, opt in ipairs(_maximized) do
            vim.o[opt.k] = opt.v
        end
        _maximized = nil
        vim.cmd('wincmd =')
    else
        _maximized = {}
        local function set(k, v)
            table.insert(_maximized, 1, { k = k, v = vim.o[k] })
            vim.o[k] = v
        end
        set('winwidth', 999)
        set('winheight', 999)
        set('winminwidth', 10)
        set('winminheight', 4)
        vim.cmd('wincmd =')
    end
    -- `QuitPre` seems to be executed even if we quit a normal window, so we don't want that
    -- `VimLeavePre` might be another consideration? Not sure about differences between the 2
    vim.api.nvim_create_autocmd('ExitPre', {
        once = true,
        group = vim.api.nvim_create_augroup('lazyvim_restore_max_exit_pre', { clear = true }),
        desc = 'Restore width/height when close Neovim while maximized',
        callback = function()
            M.maximize(false)
        end,
    })
end

-- Returns a list of regular and extmark signs sorted by priority (low to high)
local function get_signs(buf, lnum)
    -- Get regular signs
    local signs = {}

    -- Get extmark signs
    local extmarks = vim.api.nvim_buf_get_extmarks(buf, -1, { lnum - 1, 0 }, { lnum - 1, -1 }, { details = true, type = 'sign' })
    for _, extmark in pairs(extmarks) do
        signs[#signs + 1] = {
            name = extmark[4].sign_hl_group or extmark[4].sign_name or '',
            text = extmark[4].sign_text,
            texthl = extmark[4].sign_hl_group,
            priority = extmark[4].priority,
        }
    end

    -- Sort by priority
    table.sort(signs, function(a, b)
        return (a.priority or 0) < (b.priority or 0)
    end)

    return signs
end

local function icon(sign, len)
    sign = sign or {}
    len = len or 2
    local text = vim.fn.strcharpart(sign.text or '', 0, len)
    text = text .. string.rep(' ', len - vim.fn.strchars(text))
    return sign.texthl and ('%#' .. sign.texthl .. '#' .. text .. '%*') or text
end

-- https://github.com/LazyVim/LazyVim/blob/39ca76c9607a7d92aff5b97c50b7ccbf1b2d46b6/lua/lazyvim/util/ui.lua#L94
M.statuscolumn = function()
    local win = vim.g.statusline_winid
    local buf = vim.api.nvim_win_get_buf(win)
    local show_signs = vim.wo[win].signcolumn ~= 'no'

    local components = { '', '', '' } -- left, middle, right

    if show_signs then
        local signs = get_signs(buf, vim.v.lnum)

        local left, right
        for _, s in ipairs(signs) do
            if s.name and s.name:find('GitSign') then
                right = s
            else
                left = s
            end
        end

        -- Left: any sign or non-git sign
        components[1] = icon(left) or ''
        components[3] = icon(right) or ''
    end

    -- Numbers in Neovim are weird
    -- They show when either number or relativenumber is true
    local is_num = vim.wo[win].number
    local is_relnum = vim.wo[win].relativenumber
    if (is_num or is_relnum) and vim.v.virtnum == 0 then
        components[2] = '%l' -- 0.11 handles both the current and other lines with %l
        components[2] = '%=' .. components[2] .. ' ' -- right align
    end

    if vim.v.virtnum ~= 0 then
        components[2] = '%= '
    end

    return table.concat(components, '')
end

return M
