return {
	{
		"AlexvZyl/nordic.nvim",
		name = "nordic",
		priority = 1000,
		config = function()
			require("nordic").load() -- Nordic's way of setting the colorscheme
		end,
	},
}
