local lsp_status_ok, _ = pcall(require, "lspconfig")
if not lsp_status_ok then
  return
end

local cmp_status_ok, cmp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  return
end

local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = " " },
    { name = "DiagnosticSignWarn", text = " " },
    { name = "DiagnosticSignHint", text = " " },
    { name = "DiagnosticSignInfo", text = " " },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    -- virtual_lines = false,
    -- virtual_text = false,
    -- virtual_text = {
    --   -- spacing = 7,
    --   -- update_in_insert = false,
    --   -- severity_sort = true,
    --   -- prefix = "<-",
    --   prefix = " ●",
    --   source = "if_many", -- Or "always"
    --   -- format = function(diag)
    --   --   return diag.message .. "blah"
    --   -- end,
    -- },

    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      -- style = "minimal",
      border = "single",
      -- border = {"▄","▄","▄","█","▀","▀","▀","█"},
      source = "if_many", -- Or "always"
      header = "",
      prefix = "",
      -- width = 40,
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
    width = 80,
    max_height = 20,
  })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
--[[ M.capabilities = cmp.update_capabilities(M.capabilities) ]]
M.capabilities = cmp.default_capabilities(M.capabilities)

local function lsp_highlight_document(client)
  -- if client.server_capabilities.document_highlight then
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  -- end
end

local format = function() vim.lsp.buf.format {
    filter = function(client) return client.name ~= "tsserver" end
  }
end

local function keymaps()
  local Remap = require("user.keymaps.setup")
  local telescopeBuiltins = require("telescope.builtin")
  local nnoremap = Remap.nnoremap
  local inoremap = Remap.inoremap

  nnoremap("gD", function() vim.lsp.buf.declaration() end)
  nnoremap("gd", function() vim.lsp.buf.definition() end)
  nnoremap("gi", function() vim.lsp.buf.implementation() end)
  --[[ nnoremap("gr", function() vim.lsp.buf.references() end) ]]
  nnoremap("gr", telescopeBuiltins.lsp_references)
  --[[ nnoremap("K", function() vim.lsp.buf.signature_help() end) ]]
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
  nnoremap("<leader>ff", format)
end

M.on_attach = function(client)
  keymaps()
  lsp_highlight_document(client)

  if client.name == "jdtls" then
    --[[ client.resolved_capabilities.document_formatting = false ]]
    -- client.resolved_capabilities.textDocument.completionItem.snippetSupport = false
    vim.lsp.codelens.refresh()
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()
    -- require("jdtls.setup").add_commands()
  end

end

return M
