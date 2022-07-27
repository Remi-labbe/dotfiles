local lsp_status_ok, _ = pcall(require, "lspconfig")
if not lsp_status_ok then
    return
end

local cmp_status_ok, cmp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
    return
end

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp.update_capabilities(capabilities)

local function lsp_highlight_document(client)
    -- if client.server_capabilities.document_highlight then
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        return
    end
    illuminate.on_attach(client)
    -- end
end

local function keymaps()
    local Remap = require("user.keymaps.setup")
    local nnoremap = Remap.nnoremap
    local inoremap = Remap.inoremap

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
end

M.on_attach = function(client)
    keymaps()
    lsp_highlight_document(client)

    if client.name == "jdt.ls" then
        -- TODO: instantiate capabilities in java file later
        client.resolved_capabilities.document_formatting = false
        M.capabilities.textDocument.completion.completionItem.snippetSupport = false
        vim.lsp.codelens.refresh()
        if JAVA_DAP_ACTIVE then
            require("jdtls").setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
        end
    end
end

return M
