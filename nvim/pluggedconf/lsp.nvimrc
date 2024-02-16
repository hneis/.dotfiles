" LSP config - https://github.com/neovim/nvim-lspconfig 
" LSPs - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

lua << EOF
-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    completion = {
      autocomplete = false
    },
snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
},
window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
['<C-b>'] = cmp.mapping.scroll_docs(-4),
['<C-f>'] = cmp.mapping.scroll_docs(4),
['<C-Space>'] = cmp.mapping.complete(),
['<C-e>'] = cmp.mapping.abort(),
['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
{ name = 'nvim_lsp' },
-- { name = 'vsnip' }, -- For vsnip users.
-- { name = 'luasnip' }, -- For luasnip users.
{ name = 'ultisnips' }, -- For ultisnips users.
-- { name = 'snippy' }, -- For snippy users.
}, {
    { name = 'buffer' },
})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
    })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
    })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
    { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
    })

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Mappings.

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable Omni-completion
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   local opts = { noremap=true, silent=true }
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>aa', '<cmd>lua vim.diagnostic.setqflist()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>]', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>g', '<cmd>lua vim.lsp.buf.format({ async = true})<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'i', '<c-i>', "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
end


local lspconfig = require('lspconfig')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
table.insert(runtime_path, "?.lua")
table.insert(runtime_path, "/usr/share/5.3/?.lua")
table.insert(runtime_path, "/usr/share/lua/5.3/?/init.lua")

local lib = vim.api.nvim_get_runtime_file("", true)
table.insert(lib, "/usr/lib/lua-language-server/meta/3rd/love2d")

local lspconfig_configs = require'lspconfig.configs'
local lspconfig_util = require 'lspconfig.util'

local function on_new_config(new_config, new_root_dir)
  local function get_typescript_server_path(root_dir)
    local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
    return project_root and (lspconfig_util.path.join(project_root, 'node_modules', 'typescript', 'lib'))
      or ''
  end

  if
    new_config.init_options
    and new_config.init_options.typescript
    and new_config.init_options.typescript.tsdk == ''
  then
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end
end

local volar_cmd = {'vue-language-server', '--stdio'}
local volar_root_dir = lspconfig_util.root_pattern 'package.json'

lspconfig_configs.volar_api = {
  default_config = {
    cmd = volar_cmd,
    root_dir = volar_root_dir,
    on_new_config = on_new_config,
    filetypes = { 'vue'},
    -- If you want to use Volar's Take Over Mode (if you know, you know)
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    init_options = {
      typescript = {
        tsdk = ''
      },
      languageFeatures = {
        implementation = true, -- new in @volar/vue-language-server v0.33
        references = true,
        definition = true,
        typeDefinition = true,
        callHierarchy = true,
        hover = true,
        rename = true,
        renameFileRefactoring = true,
        signatureHelp = true,
        codeAction = true,
        workspaceSymbol = true,
        completion = {
          defaultTagNameCase = 'both',
          defaultAttrNameCase = 'kebabCase',
          getDocumentNameCasesRequest = false,
          getDocumentSelectionRequest = false,
        },
      }
    },
  }
}
-- lspconfig.volar_api.setup{}

lspconfig_configs.volar_doc = {
  default_config = {
    cmd = volar_cmd,
    root_dir = volar_root_dir,
    on_new_config = on_new_config,

    filetypes = { 'vue'},
    -- If you want to use Volar's Take Over Mode (if you know, you know):
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    init_options = {
      typescript = {
        tsdk = ''
      },
      languageFeatures = {
        implementation = true, -- new in @volar/vue-language-server v0.33
        documentHighlight = true,
        documentLink = true,
        codeLens = { showReferencesNotification = true},
        -- not supported - https://github.com/neovim/neovim/pull/15723
        semanticTokens = false,
        diagnostics = true,
        schemaRequestService = true,
      }
    },
  }
}
-- lspconfig.volar_doc.setup{}

lspconfig_configs.volar_html = {
  default_config = {
    cmd = volar_cmd,
    root_dir = volar_root_dir,
    on_new_config = on_new_config,

    filetypes = { 'vue'},
    -- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    init_options = {
      typescript = {
        tsdk = ''
      },
      documentFeatures = {
        selectionRange = true,
        foldingRange = true,
        linkedEditingRange = true,
        documentSymbol = true,
        -- not supported - https://github.com/neovim/neovim/pull/13654
        documentColor = false,
        documentFormatting = {
          defaultPrintWidth = 100,
        },
      }
    },
  }
}
-- lspconfig.volar_html.setup{}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = lib,
        checkThirdParty = false,
        ignoreSubmodules = false,
        useGitIgnore = false,
        preloadFileSize = 65536,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 
    -- 'ltex', 
    'gopls', 
    'bashls',
    --'cssls', 
    'html',
    'phpactor',
    'eslint',
    'clojure_lsp',
    --'tsserver',
    --'vuels',
    'volar',
    'volar_api',
    'volar_html',
    'volar_doc',
    --'emmet_ls',
    --'cssmodules_ls',
    'arduino_language_server',
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

-- Go import
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end



EOF

" Automatic go import
autocmd BufWritePre *.go lua OrgImports(1000)
