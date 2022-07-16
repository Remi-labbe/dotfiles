local Remap = require("user.keymaps.setup")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local kind_status_ok, lspkind = pcall(require, "lspkind")
if not kind_status_ok then
    return
end

local tabnine_status_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not tabnine_status_ok then
    return
end

require("luasnip.loaders.from_vscode").lazy_load()

local source_mapping = {
    nvim_lsp = "[LSP]",
    nvim_lua = "[LUA]",
    luasnip = "[SNIP]",
    cmp_tabnine = "[TN]",
    buffer = "[BUF]",
    path = "[Path]",
}

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `luasnip` user.
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-space>"] = cmp.mapping.complete(),
    }),

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. " " .. menu
                end
                vim_item.kind = ""
            end
            vim_item.menu = menu
            return vim_item
        end,
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "cmp_tabnine" },
        { name = "path" },
        { name = "buffer" },
    },
})

tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
            nnoremap("gD", function() vim.lsp.buf.declaration() end)
            nnoremap("gd", function() vim.lsp.buf.definition() end)
            nnoremap("gi", function() vim.lsp.buf.implementation() end)
            nnoremap("gr", function() vim.lsp.buf.references() end)
            nnoremap("K", function() vim.lsp.buf.hover() end)
            nnoremap("<leader>ws", function() vim.lsp.buf.workspace_symbol() end)
            nnoremap("<leader>wa", function() vim.lsp.buf.add_workspace_folder() end)
            nnoremap("<leader>wr", function() vim.lsp.buf.remove_workspace_folder() end)
            nnoremap("gl", function() vim.diagnostic.open_float() end)
            nnoremap("[d", function() vim.diagnostic.goto_next() end)
            nnoremap("]d", function() vim.diagnostic.goto_prev() end)
            nnoremap("<leader>ca", function() vim.lsp.buf.code_action() end)
            nnoremap("<leader>rn", function() vim.lsp.buf.rename() end)
            inoremap("<C-k>", function() vim.lsp.buf.signature_help() end)
            nnoremap("<leader>ff", function() vim.lsp.buf.formatting() end)
            nnoremap("<leader>q", function() vim.diagnostic.setloclist() end)
        end,
    }, _config or {})
end


lspconfig.sumneko_lua.setup(config({
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
}))

lspconfig.rust_analyzer.setup(config())

lspconfig.clangd.setup(config())

lspconfig.tsserver.setup(config())

lspconfig.pyright.setup(config())
