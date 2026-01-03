return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    }
                },
                file_ignore_patterns = {
                    "node_modules",
                    ".git/",
                    "dist/",
                    "build/",
                    "target/",
                    "*.pyc",
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        })

        -- Load fzf extension
        require('telescope').load_extension('fzf')

        local builtin = require('telescope.builtin')
        
        -- File pickers
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Recent files" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
        
        -- Search pickers
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Grep string under cursor" })
        
        -- Git pickers
        vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git commits" })
        vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Git status" })
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Git branches" })
        
        -- LSP pickers
        vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = "LSP references" })
        vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = "LSP definitions" })
        vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = "LSP implementations" })
        vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = "Document symbols" })
        vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
        
        -- Other pickers
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
        vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = "Quickfix list" })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Keymaps" })
        vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = "Commands" })

        -- Find files in nvim config
        vim.keymap.set('n', '<leader>fi', function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "Find in nvim config" })
    end
}
