local lsp = require('lsp-zero').preset({})

local lspconfig = require("lspconfig")

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps(opts)

  vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function () vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function () vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function () vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function () vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function () vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function () vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function () vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function () vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<C-h>", function () vim.lsp.buf.signature_help() end, opts)

  if client.name == "rust_analyzer" then
    vim.keymap.set("n", "K", "<cmd>RustHoverActions<cr>", opts)
    vim.keymap.set("n", "<leader>vcr", "<cmd>RustCodeAction<cr>", opts)
    vim.keymap.set("n", "<leader>vdr", "<cmd>RustDebuggables<cr>", opts)
  end
end)

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "rust_analyzer", "tsserver", "eslint" },

  automatic_installation = true,
})

require("mason-lspconfig").setup_handlers {
  function (server_name)
    lspconfig[server_name].setup {}
  end,

  ["eslint"] = function ()
    lspconfig.eslint.setup {
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    }
  end,

  ["rust_analyzer"] = function ()
    require("rust-tools").setup {
      
    }
  end,

  -- (Optional) Configure lua language server for neovim
  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    }
  end,
}

-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- CTRL+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

  }
})
