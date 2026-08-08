vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.autoindent = true
vim.opt.smartindent = true



vim.opt.pumheight = 10   
vim.opt.pumblend  = 12
vim.opt.winblend  = 10   


local c = {
  bg          = "#06030d",
  fg          = "#7F70FF",
  comment     = "#4C3AD6",
  string      = "#6C57FF",
  str_escape  = "#563FE6",
  number      = "#6048E6",
  keyword     = "#5A2EFF",
  func        = "#7159FF",
  variable    = "#6450E6",
  param       = "#5746D9",
  type        = "#4B3ABF",
  operator    = "#5A2EFF",
  preproc     = "#4D3FCB",
  property    = "#6355E6",
  bracket     = "#5046E0",
  enum_member = "#5348D1",
  interface   = "#5346D1",
  namespace   = "#594DE0",
  type_param  = "#4C3ED1",
  decorator   = "#4B3ABF",
  label       = "#5348D1",
  enum        = "#4C3ED1",
  struct      = "#4B3ABF",
  linenr      = "#250f5c",
  linenr_act  = "#a78bfa",
  cursorline  = "#160d2f",
  selection   = "#160d2f",
  whitespace  = "#160d2f",
  error       = "#f38ba8",
  warning     = "#f9e2af",
  info        = "#89b4fa",
  pmenu_bg    = "#0f0824",
  pmenu_sel   = "#2a1c66",
  pmenu_thumb = "#5A2EFF",
  pmenu_sbar  = "#160d2f",
  border      = "#160d2f",
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Статус-лайн
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local purple_theme = {
        normal = {
          a = { bg = c.keyword,    fg = c.bg,      gui = 'bold' },
          b = { bg = c.cursorline, fg = c.fg },
          c = { bg = c.bg,         fg = c.comment },
        },
        insert = {
          a = { bg = c.string,     fg = c.bg, gui = 'bold' },
          b = { bg = c.cursorline, fg = c.fg },
          c = { bg = c.bg,         fg = c.comment },
        },
        visual = {
          a = { bg = c.func,       fg = c.bg, gui = 'bold' },
          b = { bg = c.cursorline, fg = c.fg },
          c = { bg = c.bg,         fg = c.comment },
        },
        replace = {
          a = { bg = c.error,      fg = c.bg, gui = 'bold' },
          b = { bg = c.cursorline, fg = c.fg },
          c = { bg = c.bg,         fg = c.comment },
        },
        command = {
          a = { bg = c.linenr_act, fg = c.bg, gui = 'bold' },
          b = { bg = c.cursorline, fg = c.fg },
          c = { bg = c.bg,         fg = c.comment },
        },
        inactive = {
          a = { bg = c.bg, fg = c.comment },
          b = { bg = c.bg, fg = c.comment },
          c = { bg = c.bg, fg = c.comment },
        },
      }

      require('lualine').setup({
        options = {
          theme = purple_theme,
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        }
      })
    end
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup({ check_ts = true })
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'c', 'python', 'bash', 'lua', 'vim', 'vimdoc' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = false },
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'pyright', 'bashls' },
        automatic_installation = true,
      })

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
      end

      lspconfig.clangd.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.bashls.setup({ capabilities = capabilities, on_attach = on_attach })
    end
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:CmpPmenuSel,Search:None",
            col_offset = -1,
            side_padding = 1,
            winblend = 15,
    }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,Search:None",
            winblend = 15,
          }),
        },
        preselect = cmp.PreselectMode.None,
        performance = {
          debounce = 60,
          throttle = 30,
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),

          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
              cmp.confirm({ select = false })
            else
              cmp.abort()
              fallback()
            end
          end, { 'i', 's' }),

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<Up>'] = cmp.mapping(function(fallback) fallback() end, { 'i' }),
          ['<Down>'] = cmp.mapping(function(fallback) fallback() end, { 'i' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
        },
      })

      local fade_target = 15 
      local fade_steps   = 6
      local fade_delay    = 12 

      local function fade_in(win)
        if not win or not vim.api.nvim_win_is_valid(win) then return end
        local start_blend = 90
        local step = 0
        local timer = vim.loop.new_timer()
        timer:start(0, fade_delay, vim.schedule_wrap(function()
          step = step + 1
          if not vim.api.nvim_win_is_valid(win) or step > fade_steps then
            timer:stop()
            timer:close()
            return
          end
          local blend = math.floor(start_blend + (fade_target - start_blend) * (step / fade_steps))
          pcall(vim.api.nvim_set_option_value, 'winblend', blend, { win = win })
        end))
      end

      cmp.event:on('menu_opened', function(evt)
        fade_in(evt.window.win)
      end)
    end
  },
})

local function apply_dark_purple()
  local hi = vim.api.nvim_set_hl

  hi(0, "Normal",         { fg = c.fg, bg = c.bg })
  hi(0, "NormalNC",       { fg = c.fg, bg = c.bg })
  hi(0, "LineNr",         { fg = c.linenr })
  hi(0, "CursorLineNr",   { fg = c.linenr_act, bold = true })
  hi(0, "CursorLine",     { bg = c.cursorline })
  hi(0, "Visual",         { bg = c.selection })
  hi(0, "Search",         { bg = c.fg, fg = c.bg })
  hi(0, "IncSearch",      { bg = c.fg, fg = c.bg })
  hi(0, "NonText",        { fg = c.whitespace })
  hi(0, "Whitespace",     { fg = c.whitespace })
  hi(0, "EndOfBuffer",    { fg = c.bg })
  hi(0, "SignColumn",     { bg = c.bg })
  hi(0, "ColorColumn",    { bg = c.cursorline })
  hi(0, "VertSplit",      { fg = c.cursorline, bg = c.bg })
  hi(0, "Cursor",         { fg = c.bg, bg = c.fg })
  hi(0, "MatchParen",     { bg = c.cursorline, fg = c.fg })

  hi(0, "Pmenu",          { fg = c.fg, bg = c.pmenu_bg })
  hi(0, "PmenuSel",       { fg = c.bg, bg = c.linenr_act, bold = true })
  hi(0, "PmenuSbar",      { bg = c.pmenu_sbar })
  hi(0, "PmenuThumb",     { bg = c.pmenu_thumb })
  hi(0, "PmenuKind",      { fg = c.func, bg = c.pmenu_bg })
  hi(0, "PmenuKindSel",   { fg = c.bg, bg = c.linenr_act })
  hi(0, "PmenuExtra",     { fg = c.comment, bg = c.pmenu_bg })
  hi(0, "PmenuExtraSel",  { fg = c.bg, bg = c.linenr_act })
  hi(0, "NormalFloat",    { fg = c.fg, bg = c.pmenu_bg })
  hi(0, "FloatBorder",    { fg = c.border, bg = c.pmenu_bg })

  hi(0, "CmpPmenu",       { fg = c.fg, bg = c.pmenu_bg })
  hi(0, "CmpPmenuSel",    { fg = c.bg, bg = c.linenr_act, bold = true })
  hi(0, "CmpBorder",      { fg = c.border, bg = c.pmenu_bg })
  hi(0, "CmpItemAbbr",           { fg = c.fg })
  hi(0, "CmpItemAbbrMatch",      { fg = c.linenr_act, bold = true })
  hi(0, "CmpItemAbbrMatchFuzzy", { fg = c.linenr_act, bold = true })
  hi(0, "CmpItemKind",           { fg = c.func })
  hi(0, "CmpItemMenu",           { fg = c.comment, italic = true })

  hi(0, "DiagnosticError", { fg = c.error })
  hi(0, "DiagnosticWarn",  { fg = c.warning })
  hi(0, "DiagnosticInfo",  { fg = c.info })
  hi(0, "DiagnosticHint",  { fg = c.info })

  hi(0, "Comment",        { fg = c.comment, italic = true })
  hi(0, "String",         { fg = c.string })
  hi(0, "Character",      { fg = c.string })
  hi(0, "Number",         { fg = c.number })
  hi(0, "Boolean",        { fg = c.number })
  hi(0, "Float",          { fg = c.number })
  hi(0, "Keyword",        { fg = c.keyword, bold = true })
  hi(0, "Statement",      { fg = c.keyword })
  hi(0, "Conditional",    { fg = c.keyword })
  hi(0, "Repeat",         { fg = c.keyword })
  hi(0, "Label",          { fg = c.label })
  hi(0, "Exception",      { fg = c.keyword })
  hi(0, "Operator",       { fg = c.operator })
  hi(0, "PreProc",        { fg = c.preproc })
  hi(0, "Include",        { fg = c.preproc })
  hi(0, "Define",         { fg = c.preproc })
  hi(0, "Macro",          { fg = c.preproc })
  hi(0, "PreCondit",      { fg = c.preproc })
  hi(0, "Type",           { fg = c.type, italic = true })
  hi(0, "Structure",      { fg = c.struct, italic = true })
  hi(0, "Typedef",        { fg = c.type, italic = true })
  hi(0, "StorageClass",   { fg = c.type, italic = true })
  hi(0, "Function",       { fg = c.func })
  hi(0, "Identifier",     { fg = c.variable })
  hi(0, "Parameter",      { fg = c.param, italic = true })
  hi(0, "Special",        { fg = c.property })
  hi(0, "SpecialChar",    { fg = c.property })
  hi(0, "Tag",            { fg = c.property })
  hi(0, "Delimiter",      { fg = c.bracket })
  hi(0, "SpecialComment", { fg = c.comment, italic = true })
  hi(0, "Debug",          { fg = c.fg })

  hi(0, "@comment",               { fg = c.comment, italic = true })
  hi(0, "@string",                { fg = c.string })
  hi(0, "@string.escape",         { fg = c.str_escape })
  hi(0, "@string.special",        { fg = c.str_escape })
  hi(0, "@number",                { fg = c.number })
  hi(0, "@boolean",               { fg = c.number })
  hi(0, "@float",                 { fg = c.number })
  hi(0, "@keyword",               { fg = c.keyword, bold = true })
  hi(0, "@keyword.function",      { fg = c.keyword })
  hi(0, "@keyword.return",        { fg = c.keyword })
  hi(0, "@keyword.operator",      { fg = c.operator })
  hi(0, "@operator",              { fg = c.operator })
  hi(0, "@function",              { fg = c.func })
  hi(0, "@function.builtin",      { fg = c.func })
  hi(0, "@function.macro",        { fg = c.preproc })
  hi(0, "@variable",              { fg = c.variable })
  hi(0, "@variable.builtin",      { fg = c.variable })
  hi(0, "@parameter",             { fg = c.param, italic = true })
  hi(0, "@type",                  { fg = c.type, italic = true })
  hi(0, "@type.builtin",          { fg = c.type, italic = true })
  hi(0, "@structure",             { fg = c.struct, italic = true })
  hi(0, "@class",                 { fg = c.type, italic = true })
  hi(0, "@interface",             { fg = c.interface, italic = true })
  hi(0, "@enum",                  { fg = c.enum })
  hi(0, "@enumMember",            { fg = c.enum_member })
  hi(0, "@namespace",             { fg = c.namespace })
  hi(0, "@property",              { fg = c.property })
  hi(0, "@field",                 { fg = c.property })
  hi(0, "@attribute",             { fg = c.decorator, italic = true })
  hi(0, "@label",                 { fg = c.label })
  hi(0, "@preproc",               { fg = c.preproc })
  hi(0, "@define",                { fg = c.preproc })
  hi(0, "@macro",                 { fg = c.preproc })
  hi(0, "@punctuation.bracket",   { fg = c.bracket })
  hi(0, "@punctuation.delimiter", { fg = c.bracket })
  hi(0, "@tag",                   { fg = c.property })
  hi(0, "@tag.delimiter",         { fg = c.bracket })
  hi(0, "@tag.attribute",         { fg = c.property })
  hi(0, "@constant",              { fg = c.number })
  hi(0, "@constant.builtin",      { fg = c.number })
  hi(0, "@constructor",           { fg = c.func })
  hi(0, "@typeParameter",         { fg = c.type_param })
  hi(0, "@module",                { fg = c.namespace })

  hi(0, "@lsp.type.comment",       { fg = c.comment, italic = true })
  hi(0, "@lsp.type.string",        { fg = c.string })
  hi(0, "@lsp.type.number",        { fg = c.number })
  hi(0, "@lsp.type.keyword",       { fg = c.keyword, bold = true })
  hi(0, "@lsp.type.function",      { fg = c.func })
  hi(0, "@lsp.type.variable",      { fg = c.variable })
  hi(0, "@lsp.type.parameter",     { fg = c.param, italic = true })
  hi(0, "@lsp.type.type",          { fg = c.type, italic = true })
  hi(0, "@lsp.type.class",         { fg = c.type, italic = true })
  hi(0, "@lsp.type.enum",          { fg = c.enum })
  hi(0, "@lsp.type.enumMember",    { fg = c.enum_member })
  hi(0, "@lsp.type.interface",     { fg = c.interface, italic = true })
  hi(0, "@lsp.type.namespace",     { fg = c.namespace })
  hi(0, "@lsp.type.property",      { fg = c.property })
  hi(0, "@lsp.type.macro",         { fg = c.preproc })
  hi(0, "@lsp.type.struct",        { fg = c.struct, italic = true })
  hi(0, "@lsp.type.typeParameter", { fg = c.type_param })
  hi(0, "@lsp.type.decorator",     { fg = c.decorator, italic = true })
  hi(0, "@lsp.type.label",         { fg = c.label })
end

apply_dark_purple()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_dark_purple,
})

local function make_transparent()
  local highlights = {
    "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
    "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
    "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
    "SignColumn", "CursorLine", "CursorLineNr",
    "EndOfBuffer", "TabLine", "TabLineFill", "TabLineSel",
    "VertSplit",
    "Search", "IncSearch", "MatchParen",
  }
  for _, group in ipairs(highlights) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
  end
end
make_transparent()
vim.api.nvim_create_autocmd("ColorScheme", { callback = make_transparent })




vim.keymap.set({'n', 'v'}, 'd', '"_d', { noremap = true })
vim.keymap.set({'n', 'v'}, 'D', '"_D', { noremap = true })
vim.keymap.set('n', 'dd', '"_dd', { noremap = true })


vim.api.nvim_create_user_command('DeleteAllSilent', function()
    vim.cmd('%delete _')
end, {})


vim.cmd([[
  cnoreabbrev <expr> d (getcmdtype() == ':' && getcmdline() == 'd') ? 'd _' : 'd'
  cnoreabbrev <expr> %d (getcmdtype() == ':' && getcmdline() == '%d') ? '%d _' : '%d'
]])


vim.api.nvim_set_hl(0, 'LineNr', { fg = '#250f5c', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#a78bfa', bold = true })
