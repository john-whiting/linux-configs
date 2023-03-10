require('telescope').setup {
	pickers = {
		find_files = {
			theme = "ivy",
		}
	},
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}
require('telescope').load_extension('fzy_native')
require("telescope").load_extension("file_browser")

