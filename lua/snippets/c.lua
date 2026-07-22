require("luasnip.session.snippet_collection").clear_snippets("ocaml")

local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function header_guard()
	local name = vim.fn.expand("%:t:r") -- filename without extension
	name = name:gsub("[^%w]", "_") -- replace non-alphanumeric chars
	name = name:upper() .. "_H"
	return name
end

local snips = {
	s(
		{ trig = "header" },
		fmt(
			[[
            #ifndef <>
            #define <>

            #endif // <>
        ]],
			{ c(1, {
				f(header_guard),
				i(nil, "insert your guard"),
			}), rep(1), rep(1) },
			{ delimiters = "<>" }
		)
	),
}

ls.add_snippets("c", snips)
ls.add_snippets("cpp", snips)

return snips
