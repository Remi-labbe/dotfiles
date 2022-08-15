local lsp_status_ok, _ = pcall(require, "lspconfig")
if not lsp_status_ok then
    return
end

require "user.lsp.handlers".setup()
require "user.lsp.lsp-signature"
require "user.lsp.mason"
require "user.lsp.null-ls"

local saga_ok, saga = pcall(require, "lspsaga")
if not saga_ok then
  return
end

saga.init_lsp_saga()
