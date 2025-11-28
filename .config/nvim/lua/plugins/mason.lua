return {
  {
    "mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "intelephense",
        "phpstan",
        "pint",
        "html-lsp",
        "css-lsp",
        "prettier",
        "typescript-language-server",
        "json-lsp",
        "bash-language-server",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint-lsp",
        "eslint_d",
        "roslyn",
        "rzls",
        "emmet-language-server",
        "tailwindcss-language-server",
        "yaml-language-server",
        "netcoredbg",
      },
    },
  },
}
