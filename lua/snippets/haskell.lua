require("luasnip.session.snippet_collection").clear_snippets("haskell")

local ls = require("luasnip")

local haskell_snippets = require("haskell-snippets").all
ls.add_snippets("haskell", haskell_snippets, { key = "haskell" })

local s = ls.snippet
local i = ls.insert_node
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
ls.add_snippets("haskell", {
	s(
		{ trig = "testcase" },
		fmt(
			[[
            <> :: TestTree  
            <> = testCase "<>"
                $ <>
            ]],
			{ i(1, "test"), rep(1), i(2, "test"), i(3, "undefined") },
			{ delimiters = "<>" }
		)
	),
})
