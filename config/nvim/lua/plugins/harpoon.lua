return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require('harpoon')
        
        -- Initialize harpoon
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            }
        })

        -- Helper function to use telescope on harpoon list
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = require("telescope.config").values.file_previewer({}),
                sorter = require("telescope.config").values.generic_sorter({}),
            }):find()
        end

        -- Keymaps
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, 
            { desc = "Harpoon: Add file" })
        
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Harpoon: Toggle menu" })
        
        vim.keymap.set("n", "<leader>fl", function() toggle_telescope(harpoon:list()) end,
            { desc = "Harpoon: Telescope view" })

        -- Navigate between harpoon marks
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end,
            { desc = "Harpoon: Go to file 1" })
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end,
            { desc = "Harpoon: Go to file 2" })
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end,
            { desc = "Harpoon: Go to file 3" })
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end,
            { desc = "Harpoon: Go to file 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end,
            { desc = "Harpoon: Previous" })
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end,
            { desc = "Harpoon: Next" })
    end
}
