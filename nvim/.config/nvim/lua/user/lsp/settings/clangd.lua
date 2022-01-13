return {
  filetype = { "c", "cpp", "objc", "objcpp" },
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  -- root_dir = util.root_pattern("Makefile", ".git"),
}
