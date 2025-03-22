local thisIsATest = "This is also a test"

return {
	require("luasnip").snippet({ trig = "class" }, { t("public class blep" .. thisIsATest) }),
}
