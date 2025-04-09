require("luasnip.session.snippet_collection").clear_snippets "haskell"

local ls = require('luasnip')

local haskell_snippets = require('haskell-snippets').all
ls.add_snippets('haskell', haskell_snippets, { key = 'haskell' })

