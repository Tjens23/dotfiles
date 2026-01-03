return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            local configs = require("nvim-treesitter.configs")
            ---@diagnostic disable-next-line: missing-fields
            configs.setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                        },
                    },
                },
                -- enable syntax highlighting
                highlight = {
                    enable = true,
                },
                -- enable indentation
                indent = { enable = true },
                -- enable autotagging (w/ nvim-ts-autotag plugin)
                autotag = { enable = true },
                -- ensure these language parsers are installed
                ensure_installed = {
                    -- Lua & Vim
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    -- Python
                    "python",
                    -- JavaScript/TypeScript/React
                    "javascript",
                    "typescript",
                    "tsx",
                    "jsx",
                    -- Go
                    "go",
                    "gomod",
                    "gosum",
                    "gowork",
                    -- Rust
                    "rust",
                    "toml",
                    -- C/C++
                    "c",
                    "cpp",
                    "cmake",
                    -- Java
                    "java",
                    -- Web/Frontend
                    "html",
                    "css",
                    "scss",
                    "json",
                    "yaml",
                    "astro",
                    "vue",
                    "svelte",
                    -- Other
                    "markdown",
                    "markdown_inline",
                    "bash",
                    "dockerfile",
                    "gitignore",
                    "sql",
                    "graphql",
                    "regex",
                },
                -- auto install above language parsers
                auto_install = false,
            })
        end
    }
}
