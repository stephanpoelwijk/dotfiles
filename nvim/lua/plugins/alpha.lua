return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			"",
			"                                          ",
"        ,..",
"        /  \\`.",
"       |    \\ \\",
"       :     : \\",
"       |     |  \\..----.__",
"       | \\   |  '         `-.",
"       :  \\. | ,-.           `.      ____",
"        \\  \\`'/   `.           `._,-','  )",
"         \\  \\(  .   \\            \\,-'   /",
"          `-<)\\  `.  \\           |     /",
"             \\ ) ( o. `.         /   ,'",
"              `/  `--`-.`._.--'>'_,-'",
"    /  .      (     ,\\__)o)(\"`--'",
"   (_,/;  ,-.  `---(`.,/    )",
"     // ,',.|   ,'  `-(\\- -'",
"    //,','/ ; ,'  ,(!|!)`.",
"   ,'/,' / /  `.  `-`|'-' )",
"   `-'  / /    |`----^--(\"",
"       / ,   _,:        /",
"      (  `--'  _\\    _,/",
"       `------'  \\ /\\,:,--.",
"               ,'` )'-.___,'",
"              (__,'",
"",
"Are you pondering what I'm pondering?",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
