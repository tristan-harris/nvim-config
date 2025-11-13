return {
    "iamcco/markdown-preview.nvim",
    init = function()
        vim.g.mkdp_auto_close = 0
        vim.g.mkdp_combine_preview = 1
        vim.g.mkdp_port = "9097"

        -- set MarkdownPreview to open in new Firefox window (need to translate to lua at some point)
        vim.cmd([[
            function OpenMarkdownPreview (url)
            execute "silent ! firefox --new-window " . a:url
            endfunction
            let g:mkdp_browserfunc = 'OpenMarkdownPreview'
            ]])
    end,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
}
