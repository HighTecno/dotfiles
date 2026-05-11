local ok, blink = pcall(require, 'blink.cmp')
if not ok then return end

blink.setup({
  keymap = {
    preset = 'default',
    ['<C-y>']     = { 'select_and_accept' },
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>']     = { 'hide', 'fallback' },
    ['<Tab>']     = { 'snippet_forward', 'fallback' },
    ['<S-Tab>']   = { 'snippet_backward', 'fallback' },
    ['<C-p>']     = { 'select_prev', 'fallback' },
    ['<C-n>']     = { 'select_next', 'fallback' },
    ['<C-b>']     = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>']     = { 'scroll_documentation_down', 'fallback' },
  },

  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'mono',
    kind_icons = {
      Text          = '󰉿', Method   = '󰊕', Function    = '󰊕',
      Constructor   = '󰒓', Field    = '󰜢', Variable    = '󰆦',
      Property      = '󰖷', Class    = '󱡠', Interface   = '󱡠',
      Struct        = '󱡠', Module   = '󰅩', Unit        = '󰪚',
      Value         = '󰰡', Enum     = '󰦨', EnumMember  = '󰦨',
      Keyword       = '󰻾', Constant = '󰏿', Snippet     = '󱄽',
      Color         = '󰏘', File     = '󰈔', Reference   = '󰬲',
      Folder        = '󰉋', Event    = '󱐋', Operator    = '󰪚',
      TypeParameter = '󰬛',
    },
  },

  completion = {
    accept = {
      auto_brackets = { enabled = true },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      treesitter_highlighting = true,
      window = {
        border = 'rounded',
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
      },
    },
    list = {
      selection = { preselect = true, auto_insert = true },
    },
    menu = {
      border = 'rounded',
      winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
      draw = {
        treesitter = { 'lsp' },
        columns = {
          { 'label', 'label_description', gap = 1 },
          { 'kind_icon', gap = 1, 'kind' },
        },
      },
    },
  },

  signature = {
    enabled = true,
    window = {
      border = 'rounded',
      winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      lsp      = { score_offset = 5 },
      snippets = { score_offset = 3, opts = { friendly_snippets = true } },
      buffer   = { score_offset = -3, opts = { get_bufnrs = function()
        return vim.tbl_filter(function(b)
          return vim.api.nvim_buf_get_option(b, 'buftype') == ''
        end, vim.api.nvim_list_bufs())
      end } },
    },
  },
})
