require("luasnip.session.snippet_collection").clear_snippets("ocaml")

local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snips = {
	s(
		{ trig = "deriving" },
		fmt(
			[[
            [@@deriving <>]
            ]],
			{ i(1, "eq") },
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "mod_with_sig" },
		fmt(
			[[
            module <> : sig 
              <>
            end
        ]],
			{ i(1, "NAME"), i(2, "") },
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "mod_with_sig_and_impl" },
		fmt(
			[[
            module <> : sig 
              <>
            end = struct 
              <>
            end
        ]],
			{ i(1, "NAME"), i(2, ""), i(3, "") },
			{ delimiters = "<>" }
		)
	),
}

ls.add_snippets("ocaml", snips)

return snips
