local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

local settings = {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}

local servers = {
  "lua_ls",
}

mason.setup(settings)
mason_lspconfig.setup({
  ensure_installed = servers,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

--[[ local fidget_status, fidget = pcall(require, "fidget") ]]
--[[ if not fidget_status then ]]
--[[   return ]]
--[[ end ]]
--[[]]
--[[ fidget.setup {} ]]

local util = require("lspconfig.util")

local function config(_config)
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  return vim.tbl_deep_extend("force", opts, _config or {})
end

--[[ lspconfig.clangd.setup(config()) ]]

lspconfig.pyright.setup(config())

--[[ lspconfig.tsserver.setup(config()) ]]
-- OR
--[[ lspconfig.tsserver.setup(config({ ]]
--[[   importModuleSpecifierPreference = "relative", ]]
--[[ })) ]]
--[[]]
require("typescript").setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  preferences = {
    importModuleSpecifierPreference = "relative",
  },
  server = config(),
})

--[[   server = config({ ]]
--[[     importModuleSpecifierPreference = "relative", ]]
--[[   }), ]]
--[[ }) ]]

-- lspconfig.html.setup(config())

--[[ lspconfig.emmet_ls.setup(config()) ]]
--
lspconfig.cssls.setup(config())

lspconfig.lua_ls.setup(config({
  root_dir = util.root_pattern(".luarc.json", ".luacheckrc", ".stylua.toml",
    "stylua.toml", "selene.toml", ".git", ".gitignore"),
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
      telemetry = {
        enable = false,
      },
    },
  },
}))

lspconfig.taplo.setup(config())

local rust_opts = require "user.lsp.settings.rust"
-- lspconfig.rust_analyzer.setup(config(rust_opts))
-- OR
local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
if not rust_tools_status_ok then
  return
end
rust_tools.setup(rust_opts)

lspconfig.ocamllsp.setup(config())

lspconfig.yamlls.setup(config())

lspconfig.lemminx.setup(config())

--[[ lspconfig.csharp_ls.setup(config()) ]]

local home = os.getenv "HOME"

lspconfig.omnisharp.setup(config({
  cmd = { "dotnet", home .. "/.local/share/nvim/mason/packages/omnisharp/OmniSharp.dll" },

  -- Enables support for reading code style, naming convention and analyzer
  -- settings from .editorconfig.
  enable_editorconfig_support = true,

  -- If true, MSBuild project system will only load projects for files that
  -- were opened in the editor. This setting is useful for big C# codebases
  -- and allows for faster initialization of code navigation features only
  -- for projects that are relevant to code that is being edited. With this
  -- setting enabled OmniSharp may load fewer projects and may thus display
  -- incomplete reference lists for symbols.
  enable_ms_build_load_projects_on_demand = false,

  -- Enables support for roslyn analyzers, code fixes and rulesets.
  enable_roslyn_analyzers = false,

  -- Specifies whether 'using' directives should be grouped and sorted during
  -- document formatting.
  organize_imports_on_format = true,

  -- Enables support for showing unimported types and unimported extension
  -- methods in completion lists. When committed, the appropriate using
  -- directive will be added at the top of the current file. This option can
  -- have a negative impact on initial completion responsiveness,
  -- particularly for the first few completion sessions after opening a
  -- solution.
  enable_import_completion = true,

  -- Specifies whether to include preview versions of the .NET SDK when
  -- determining which version to use for project loading.
  sdk_include_prereleases = true,

  -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
  -- true
  analyze_open_documents_only = false,
}))

lspconfig.gopls.setup(config())

lspconfig.terraformls.setup(config())

lspconfig.bufls.setup(config())

lspconfig.tailwindcss.setup(config())
