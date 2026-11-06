{
  lua = ["lsp" "format" "test"];
  nix = ["lsp" "format" "lint"];
  python = ["lsp" "format" "lint" "dap" "test"];
  go = ["lsp" "format" "lint" "dap"];
  rust = ["lsp" "format" "dap" "test"];
  shell = ["lsp" "format" "lint"];
  html = ["lsp" "format"];
  css = ["format" "lint"];
  typescript = ["lsp" "format" "lint"];
  svelte = ["lsp" "format" "lint"];
  tailwind = ["lsp"];
  json = ["lsp" "format"];
  yaml = ["lsp"];
  sql = ["lsp"];
  docker = ["lsp"];
  markdown = ["format" "render"];
}
