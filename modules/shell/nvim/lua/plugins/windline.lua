return {
	"windline.nvim",
	event = "UIEnter",
	after = function()
		require("wlsample.vscode")
	end,
}
