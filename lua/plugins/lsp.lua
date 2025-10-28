return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
				-- used for completion, annotations and signatures of Neovim apis
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
						{ path = "/usr/share/awesome/lib/", words = { "awesome" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"chrisgrieser/nvim-lsp-endhints",
				event = "LspAttach",
				opts = {}, -- required, even if empty
			},
			{ "j-hui/fidget.nvim", opts = {} },
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

			-- Autoformatting
			"stevearc/conform.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local lspconfig = require("lspconfig")

			local servers = {
				bashls = true,
				clangd = true,
				gopls = {
					manual_install = true,
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							hint = { enable = true },
						},
					},
					server_capabilities = {
						semanticTokensProvider = vim.NIL,
					},
				},
				-- rust_analyzer = {
				-- 	cmd = { "rust-analyzer" },
				-- 	filetypes = { "rust" },
				-- 	capabilities = {
				-- 		experimental = {
				-- 			commands = {
				-- 				commands = {
				-- 					"rust-analyzer.showReferences",
				-- 					"rust-analyzer.runSingle",
				-- 					"rust-analyzer.debugSingle",
				-- 				},
				-- 			},
				-- 		},
				-- 	},
				-- 	settings = {
				-- 		["rust-analyzer"] = {
				-- 			diagnostics = {
				-- 				enable = true,
				-- 				experimental = {
				-- 					enable = true,
				-- 				},
				-- 				styleLints = {
				-- 					enable = true,
				-- 				},
				-- 			},
				-- 			lens = {
				-- 				enable = true,
				-- 				run = {
				-- 					enable = true,
				-- 				},
				-- 				implementations = {
				-- 					enable = true,
				-- 				},
				-- 				references = {
				-- 					adt = {
				-- 						enable = true,
				-- 					},
				-- 					method = {
				-- 						enable = true,
				-- 					},
				-- 					trait = {
				-- 						enable = true,
				-- 					},
				-- 					enumVariant = {
				-- 						enable = true,
				-- 					},
				-- 				},
				-- 			},
				-- 		},
				-- 	},
				-- },

				pyright = true,
				jsonls = {
					server_capabilities = {
						documentFormattingProvider = false,
					},
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				-- cssls = {
				--   server_capabilities = {
				--     documentFormattingProvider = false,
				--   },
				-- },

				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							-- schemas = require("schemastore").yaml.schemas(),
						},
					},
				},

				tblgen_lsp_server = {
					manual_install = true,
					cmd = { "tblgen-lsp-server" },
					filetypes = { "tablegen" },
				},

				ocamllsp = {
					manual_install = true,
					cmd = { "dune", "tools", "exec", "ocamllsp" },
					settings = {
						codelens = { enable = true },
						inlayHints = { enable = true },
						syntaxDocumentation = { enable = true },
					},
					filetypes = { "ocaml", "menhir", "ocaml_interface", "ocamllex", "reason", "dune" },
					server_capabilities = { semanticTokensProvider = false },
				},
			}

			-- require("ocaml").setup()

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				"clangd",
				"stylua",
				"lua_ls",
				"haskell-language-server",
				"asm-lsp",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					if client and client:supports_method("textDocument/codeLens") then
						vim.lsp.codelens.refresh()
						vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
							buffer = bufnr,
							callback = vim.lsp.codelens.refresh,
						})
					end

					local builtin = require("telescope.builtin")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
					vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = 0 })

					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
					vim.keymap.set("n", "<leader>wd", builtin.lsp_document_symbols, { buffer = 0 })
					vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { buffer = 0 })

					vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, { buffer = 0 })
					vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, { buffer = 0 })
					vim.keymap.set(
						"n",
						"<leader>lwl",
						"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
						{ buffer = 0 }
					)
					vim.keymap.set("n", "<leader>clr", vim.lsp.codelens.run, { buffer = 0 })

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- Override server capabilities
					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end
				end,
			})

			require("custom.autoformat").setup()

			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
			lspconfig.clangd.setup({})

			vim.keymap.set("", "<localleader>l", function()
				local config = vim.diagnostic.config() or {}
				if config.virtual_text then
					vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
				else
					vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
				end
			end, { desc = "Toggle lsp_lines" })

			require("lsp")
		end,
	},
}
