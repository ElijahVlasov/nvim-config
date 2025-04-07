require("luasnip.session.snippet_collection").clear_snippets "lean"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep 

ls.add_snippets("lean", {
    s({ trig= ";to" }, { t('→') }),
    s({ trig=";b"}, {
        t('←')
    } ),
    s({ trig=";sa"}, {
        t('ₐ')
    } ),
    s({ trig=";se"}, {
        t('ₑ')
    } ),
    s({ trig=";so"}, {
        t('ₒ')
    } ),
    s({ trig=";indnat"}, fmt(
        [[
        induction <> with
        | zero =>> <>
        | succ <> <> =>> <>
        ]],
        { i(1, 'n'), i(2, "sorry"), rep(1), i(3, 'ih'), i(4, "sorry")  },
        { delimiters = "<>" }
    ))
})
