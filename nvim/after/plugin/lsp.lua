local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'pyright', -- Python LS
    'gopls', -- Go LS
    'lua_ls',
    'tsserver',
    'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("v", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "fu", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)

  vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
  vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
  vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
  vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
  vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
  vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)

  vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>')
  vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>')
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

