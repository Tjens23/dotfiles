return {
	"David-Kunz/gen.nvim",
	lazy = false,  -- Load immediately, not lazily
	opts = {
		model = "hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q8_0", -- or "llama3.2", "codellama", etc.
		quit_map = "q",
		display_mode = "vertical-split",
		show_prompt = true,
		show_model = true,
	},
	keys = {
		{
			"<C-i>",
			":Gen<CR>",
			mode = { "n", "v" },
			desc = "AI Prompt Picker"
		}
	}
}
