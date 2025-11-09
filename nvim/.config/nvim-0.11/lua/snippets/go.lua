local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
	s({ trig = "r1err", dscr = "if err != nil { return err }" }, {
		t({ "if err != nil {", "\t" }),
		t("return err"),
		t({ "", "}" }),
	}),

	s({ trig = "r2err", dscr = "if err != nil { return nil, err }" }, {
		t({ "if err != nil {", "\t" }),
		t("return nil, err"),
		t({ "", "}" }),
	}),

	s({ trig = "r3err", dscr = "if err != nil { return nil, nil, err }" }, {
		t({ "if err != nil {", "\t" }),
		t("return nil, nil, err"),
		t({ "", "}" }),
	}),
}
