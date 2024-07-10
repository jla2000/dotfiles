return {
	"dapui",
	event = "BufEnter",
	after = function()
		require("dapui").setup()
	end,
}
