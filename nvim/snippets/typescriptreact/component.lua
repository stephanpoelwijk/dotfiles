-- local t = require("luasnip").text

local bufName = vim.api.nvim_buf_get_name(0)

bufName = vim.fn.expand("%:t:r")

return {
	require("luasnip").snippet({ trig = "react_component" }, {
		t({ "export default function " .. bufName .. "({", "" }),
		t({ "  className,", "" }),
		t({ "  ...props", "" }),
		t({ ': React.ComponentProps<"div"> & { }) {', "" }),
		t({ " return (", "" }),
		t({ "   <div", "" }),
		t({ '     className={cn("w-full bg-white", className)}', "" }),
		t({ "     {...props}", "" }),
		t({ "   >", "" }),
		t({ "    </div>", "" }),
		t({ "  )", "" }),
		t({ "}", "", "" }),
		--		t({ "export { PageTitle as PageTitle }", "" }),
	}),
}
