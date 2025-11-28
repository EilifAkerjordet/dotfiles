return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        -- Tailwind with custom classRegex for Blazor Cn() function
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "Cn\\(([^)]*)\\)", '"([^"]*)"' },
                  { "Cn\\(([^)]*)\\)", "'([^']*)'" },
                  { 'Cn\\("([^"]*)"\\)', "([\\w-/:]+)" },
                },
              },
            },
          },
        },

        -- Svelte with file watcher workaround
        svelte = {
          filetypes = { "svelte" },
          on_attach = function(client, bufnr)
            if client.name == "svelte" then
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts", "*.svelte" },
                callback = function(ctx)
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
                end,
              })
            end
          end,
        },

        -- Azure Pipelines
        azure_pipelines_ls = {
          filetypes = { "yaml", "yml", "yaml.azure-pipelines" },
          single_file_support = true,
        },

        -- Emmet with custom filetypes
        emmet_language_server = {
          filetypes = {
            "css",
            "eruby",
            "html",
            "javascript",
            "javascriptreact",
            "astro",
            "less",
            "sass",
            "scss",
            "pug",
            "typescriptreact",
            "svelte",
          },
          init_options = {
            html = {
              options = {
                ["bem.enabled"] = true,
              },
            },
          },
        },

        -- Intelephense with license
        intelephense = {
          settings = {
            intelephense = {
              licenceKey = (function()
                local license_file = vim.fn.expand("$HOME/intelephense/licence.txt")
                if vim.fn.filereadable(license_file) == 1 then
                  local lines = vim.fn.readfile(license_file)
                  return lines[1] or ""
                end
                return ""
              end)(),
            },
          },
        },
      },
    },
  },
}
