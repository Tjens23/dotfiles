return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    -- Lua
                    lua = { "stylua" },
                    -- Python
                    python = { "isort", "black" },
                    -- JavaScript/TypeScript/React
                    javascript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescript = { "prettier" },
                    typescriptreact = { "prettier" },
                    -- Web
                    html = { "prettier" },
                    css = { "prettier" },
                    scss = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    -- Go
                    go = { "gofumpt", "goimports" },
                    -- Rust (handled by rust-analyzer)
                    rust = { "rustfmt" },
                    -- C/C++
                    c = { "clang_format" },
                    cpp = { "clang_format" },
                    -- Java
                    java = { "google-java-format" },
                },
                format_on_save = {
                    lsp_fallback = true,
                    timeout_ms = 500,
                },
            })

            -- Manual format keymap
            vim.keymap.set({ "n", "v" }, "<leader>f", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500,
                })
            end, { desc = "Format file or range (in visual mode)" })
        end,
    },
}
