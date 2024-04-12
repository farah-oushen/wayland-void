-----------------------------------------------------------
-- AutoFormat
-----------------------------------------------------------
require("conform").setup({
    formatters_by_ft = {
        css = { "prettierd" },
        graphql = { "prettierd" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        php = { "php_cs_fixer" },
        python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
                return { "ruff_format", "ruff_fix" }
            else
                return { "isort", "black" }
            end
        end,
        rust = { "rustfmt" },
        scss = { "prettierd" },
        sh = { "shfmt" },
        toml = { "taplo" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        yaml = { "prettierd" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
})
