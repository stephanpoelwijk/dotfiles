local namespace = "test.whatever"

return {
	s({ trig = "class" }, {
		--	t({ "namespace " .. namespace .. ";", "", "" }),
		t("public class "),
		i(1, "classname"),
		t({ "", "{", "", "}" }),
		f(function(args)
			return "// This comes from a function"
		end),
	}),
}
