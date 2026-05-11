-- Moonstone — cool slate monochrome
-- https://github.com/HighTecno/dotfiles

vim.cmd.highlight('clear')
if vim.fn.exists('syntax_on') == 1 then vim.cmd('syntax reset') end
vim.g.colors_name = 'moonstone'

local hi = function(name, val) vim.api.nvim_set_hl(0, name, val) end

local c = {
  bg        = '#0f1014',
  bg1       = '#1a1d24',
  bg2       = '#1e2228',
  bg3       = '#262930',
  bg4       = '#2a2e38',

  fg        = '#c0c8d4',
  fg_dim    = '#a8b2be',
  fg_bright = '#dce0e8',

  slate0    = '#374049',
  slate1    = '#4c5768',
  slate2    = '#607080',
  slate3    = '#7c8898',
  slate4    = '#8d97a8',
  slate5    = '#8e98a6',
  slate6    = '#9fa8b6',
  slate7    = '#b8c0ca',

  muted     = '#5d6676',
  mid       = '#788490',
}

-- ── Editor ────────────────────────────────────────────────────────────────────
hi('Normal',          { fg = c.fg,       bg = c.bg })
hi('NormalNC',        { fg = c.fg_dim,   bg = c.bg })
hi('NormalFloat',     { fg = c.fg,       bg = c.bg1 })
hi('FloatBorder',     { fg = c.slate2,   bg = c.bg1 })
hi('FloatTitle',      { fg = c.fg,       bg = c.bg1, bold = true })
hi('Cursor',          { fg = c.bg,       bg = c.fg_bright })
hi('CursorLine',      { bg = c.bg2 })
hi('CursorColumn',    { bg = c.bg2 })
hi('ColorColumn',     { bg = c.bg2 })
hi('LineNr',          { fg = c.slate1 })
hi('CursorLineNr',    { fg = c.slate4,   bold = true })
hi('SignColumn',      { bg = c.bg })
hi('FoldColumn',      { fg = c.slate2,   bg = c.bg })
hi('Folded',          { fg = c.slate3,   bg = c.bg2 })
hi('Visual',          { bg = c.bg4 })
hi('VisualNOS',       { bg = c.bg4 })
hi('Search',          { fg = c.fg_bright, bg = c.slate0,  bold = true })
hi('IncSearch',       { fg = c.bg,        bg = c.slate4,  bold = true })
hi('CurSearch',       { fg = c.bg,        bg = c.fg,      bold = true })
hi('MatchParen',      { fg = c.fg_bright, bg = c.bg4,     bold = true })
hi('Conceal',         { fg = c.muted })
hi('NonText',         { fg = c.bg3 })
hi('SpecialKey',      { fg = c.bg3 })
hi('Whitespace',      { fg = c.bg4 })
hi('EndOfBuffer',     { fg = c.bg })
hi('Directory',       { fg = c.fg_dim })
hi('Title',           { fg = c.fg_bright, bold = true })

-- ── Statusline / tabs ─────────────────────────────────────────────────────────
hi('StatusLine',      { fg = c.fg,    bg = c.bg1 })
hi('StatusLineNC',    { fg = c.muted, bg = c.bg1 })
hi('TabLine',         { fg = c.muted, bg = c.bg1 })
hi('TabLineSel',      { fg = c.bg,    bg = c.fg,  bold = true })
hi('TabLineFill',     { bg = c.bg1 })
hi('WinSeparator',    { fg = c.bg3 })
hi('WinBar',          { fg = c.fg_dim, bg = c.bg })
hi('WinBarNC',        { fg = c.muted,  bg = c.bg })

-- ── Popup menu ────────────────────────────────────────────────────────────────
hi('Pmenu',           { fg = c.fg,        bg = c.bg1 })
hi('PmenuSel',        { fg = c.fg_bright, bg = c.bg4 })
hi('PmenuSbar',       { bg = c.bg3 })
hi('PmenuThumb',      { bg = c.slate2 })
hi('PmenuKind',       { fg = c.slate4,    bg = c.bg1 })
hi('PmenuKindSel',    { fg = c.slate4,    bg = c.bg4 })
hi('PmenuExtra',      { fg = c.muted,     bg = c.bg1 })
hi('PmenuExtraSel',   { fg = c.muted,     bg = c.bg4 })
hi('WildMenu',        { fg = c.bg,        bg = c.slate4 })

-- ── Messages ──────────────────────────────────────────────────────────────────
hi('MsgArea',         { fg = c.fg_dim })
hi('MsgSeparator',    { fg = c.slate2 })
hi('MoreMsg',         { fg = c.slate4 })
hi('Question',        { fg = c.slate4 })
hi('ErrorMsg',        { fg = c.fg_bright, bold = true })
hi('WarningMsg',      { fg = c.slate6 })

-- ── Spell ─────────────────────────────────────────────────────────────────────
hi('SpellBad',        { sp = c.fg_bright, undercurl = true })
hi('SpellCap',        { sp = c.slate6,    undercurl = true })
hi('SpellRare',       { sp = c.slate4,    undercurl = true })
hi('SpellLocal',      { sp = c.mid,       undercurl = true })

-- ── Diff ──────────────────────────────────────────────────────────────────────
hi('DiffAdd',         { bg = '#161d22' })
hi('DiffChange',      { bg = '#181820' })
hi('DiffDelete',      { fg = c.slate1,   bg = '#18141a' })
hi('DiffText',        { bg = '#222238',  bold = true })
hi('diffAdded',       { link = 'DiffAdd' })
hi('diffRemoved',     { link = 'DiffDelete' })
hi('diffChanged',     { link = 'DiffChange' })

-- ── Syntax ────────────────────────────────────────────────────────────────────
hi('Comment',         { fg = c.muted,    italic = true })
hi('Constant',        { fg = c.slate5 })
hi('String',          { fg = c.slate7 })
hi('Character',       { fg = c.slate7 })
hi('Number',          { fg = c.slate4 })
hi('Float',           { fg = c.slate4 })
hi('Boolean',         { fg = c.slate4,   italic = true })
hi('Identifier',      { fg = c.fg })
hi('Function',        { fg = c.fg_bright, bold = true })
hi('Statement',       { fg = c.slate6 })
hi('Keyword',         { fg = c.slate6,   bold = true })
hi('Conditional',     { fg = c.slate6,   italic = true })
hi('Repeat',          { fg = c.slate6 })
hi('Label',           { fg = c.slate5 })
hi('Operator',        { fg = c.slate3 })
hi('Exception',       { fg = c.slate6 })
hi('PreProc',         { fg = c.fg_dim })
hi('Include',         { fg = c.fg_dim })
hi('Define',          { fg = c.fg_dim })
hi('Macro',           { fg = c.fg_dim })
hi('PreCondit',       { fg = c.fg_dim })
hi('Type',            { fg = c.slate7,   bold = true })
hi('StorageClass',    { fg = c.slate6 })
hi('Structure',       { fg = c.slate6 })
hi('Typedef',         { fg = c.slate6 })
hi('Special',         { fg = c.slate4 })
hi('SpecialChar',     { fg = c.slate4 })
hi('Tag',             { fg = c.fg_dim })
hi('Delimiter',       { fg = c.slate3 })
hi('SpecialComment',  { fg = c.muted,    italic = true })
hi('Debug',           { fg = c.slate4 })
hi('Underlined',      { underline = true })
hi('Bold',            { bold = true })
hi('Italic',          { italic = true })
hi('Ignore',          { fg = c.bg3 })
hi('Error',           { fg = c.fg_bright, bold = true })
hi('Todo',            { fg = c.bg,        bg = c.slate4, bold = true })

-- ── Treesitter ────────────────────────────────────────────────────────────────
hi('@variable',                { fg = c.fg })
hi('@variable.builtin',        { fg = c.slate5,    italic = true })
hi('@variable.parameter',      { fg = c.fg_dim })
hi('@variable.member',         { fg = c.fg_dim })
hi('@function',                { fg = c.fg_bright, bold = true })
hi('@function.builtin',        { fg = c.fg_dim,    bold = true })
hi('@function.call',           { fg = c.fg_bright })
hi('@function.macro',          { fg = c.fg_dim })
hi('@function.method',         { fg = c.fg_bright, bold = true })
hi('@function.method.call',    { fg = c.fg_bright })
hi('@constructor',             { fg = c.slate6 })
hi('@string',                  { fg = c.slate7 })
hi('@string.escape',           { fg = c.slate4 })
hi('@string.special',          { fg = c.slate4 })
hi('@string.regexp',           { fg = c.slate5 })
hi('@number',                  { fg = c.slate4 })
hi('@number.float',            { fg = c.slate4 })
hi('@boolean',                 { fg = c.slate4,    italic = true })
hi('@keyword',                 { fg = c.slate6,    bold = true })
hi('@keyword.conditional',     { fg = c.slate6,    italic = true })
hi('@keyword.return',          { fg = c.slate6,    bold = true })
hi('@keyword.function',        { fg = c.slate6,    bold = true })
hi('@keyword.operator',        { fg = c.slate3 })
hi('@keyword.import',          { fg = c.fg_dim })
hi('@keyword.repeat',          { fg = c.slate6 })
hi('@keyword.exception',       { fg = c.slate6 })
hi('@type',                    { fg = c.slate7,    bold = true })
hi('@type.builtin',            { fg = c.slate6 })
hi('@type.definition',         { fg = c.slate7,    bold = true })
hi('@comment',                 { fg = c.muted,     italic = true })
hi('@comment.documentation',   { fg = c.slate2,    italic = true })
hi('@operator',                { fg = c.slate3 })
hi('@punctuation.delimiter',   { fg = c.slate3 })
hi('@punctuation.bracket',     { fg = c.slate3 })
hi('@punctuation.special',     { fg = c.slate4 })
hi('@module',                  { fg = c.fg_dim })
hi('@namespace',               { fg = c.fg_dim })
hi('@constant',                { fg = c.slate5 })
hi('@constant.builtin',        { fg = c.slate4,    italic = true })
hi('@constant.macro',          { fg = c.fg_dim })
hi('@tag',                     { fg = c.slate6 })
hi('@tag.attribute',           { fg = c.fg_dim })
hi('@tag.delimiter',           { fg = c.slate3 })
hi('@markup.heading',          { fg = c.fg_bright, bold = true })
hi('@markup.bold',             { bold = true })
hi('@markup.italic',           { italic = true })
hi('@markup.strikethrough',    { strikethrough = true })
hi('@markup.link',             { fg = c.slate4,    underline = true })
hi('@markup.link.url',         { fg = c.slate4,    underline = true })
hi('@markup.raw',              { fg = c.slate3,    bg = c.bg2 })
hi('@markup.list',             { fg = c.slate3 })

-- ── LSP ───────────────────────────────────────────────────────────────────────
hi('DiagnosticError',              { fg = c.fg_bright })
hi('DiagnosticWarn',               { fg = c.slate7 })
hi('DiagnosticInfo',               { fg = c.slate4 })
hi('DiagnosticHint',               { fg = c.muted })
hi('DiagnosticOk',                 { fg = c.slate3 })
hi('DiagnosticVirtualTextError',   { fg = c.fg_bright, bg = '#1a1418' })
hi('DiagnosticVirtualTextWarn',    { fg = c.slate7,    bg = '#191820' })
hi('DiagnosticVirtualTextInfo',    { fg = c.slate4,    bg = '#161820' })
hi('DiagnosticVirtualTextHint',    { fg = c.muted,     bg = c.bg2 })
hi('DiagnosticUnderlineError',     { sp = c.fg_bright, undercurl = true })
hi('DiagnosticUnderlineWarn',      { sp = c.slate7,    undercurl = true })
hi('DiagnosticUnderlineInfo',      { sp = c.slate4,    undercurl = true })
hi('DiagnosticUnderlineHint',      { sp = c.muted,     undercurl = true })
hi('LspReferenceText',             { bg = c.bg4 })
hi('LspReferenceRead',             { bg = c.bg4 })
hi('LspReferenceWrite',            { bg = c.bg4, bold = true })
hi('LspInlayHint',                 { fg = c.slate1, bg = c.bg2, italic = true })
hi('LspCodeLens',                  { fg = c.slate1, italic = true })

-- ── Git signs ─────────────────────────────────────────────────────────────────
hi('GitSignsAdd',         { fg = c.slate4 })
hi('GitSignsChange',      { fg = c.slate3 })
hi('GitSignsDelete',      { fg = c.slate1 })

-- ── Telescope ─────────────────────────────────────────────────────────────────
hi('TelescopeNormal',        { fg = c.fg,    bg = c.bg })
hi('TelescopeBorder',        { fg = c.bg4,   bg = c.bg })
hi('TelescopePromptNormal',  { fg = c.fg,    bg = c.bg })
hi('TelescopePromptBorder',  { fg = c.bg4,   bg = c.bg })
hi('TelescopePromptPrefix',  { fg = c.slate4 })
hi('TelescopeSelection',     { bg = c.bg4 })
hi('TelescopeSelectionCaret',{ fg = c.slate4, bg = c.bg4 })
hi('TelescopeMatching',      { fg = c.fg_bright, bold = true })
hi('TelescopeResultsTitle',  { fg = c.bg,    bg = c.slate2 })
hi('TelescopePreviewTitle',  { fg = c.bg,    bg = c.slate2 })
hi('TelescopePromptTitle',   { fg = c.bg,    bg = c.slate4 })

-- ── Completion (blink.cmp) ────────────────────────────────────────────────────
hi('BlinkCmpMenu',                 { fg = c.fg,        bg = c.bg1 })
hi('BlinkCmpMenuBorder',           { fg = c.bg4,       bg = c.bg1 })
hi('BlinkCmpMenuSelection',        { bg = c.bg4 })
hi('BlinkCmpDoc',                  { fg = c.fg,        bg = c.bg1 })
hi('BlinkCmpDocBorder',            { fg = c.bg4,       bg = c.bg1 })
hi('BlinkCmpLabel',                { fg = c.fg })
hi('BlinkCmpLabelMatch',           { fg = c.fg_bright, bold = true })
hi('BlinkCmpKind',                 { fg = c.slate4 })
hi('BlinkCmpSignatureHelp',        { fg = c.fg,        bg = c.bg1 })
hi('BlinkCmpSignatureHelpBorder',  { fg = c.bg4,       bg = c.bg1 })

-- ── Which-key ─────────────────────────────────────────────────────────────────
hi('WhichKey',          { fg = c.slate4 })
hi('WhichKeyGroup',     { fg = c.fg_dim })
hi('WhichKeyDesc',      { fg = c.fg })
hi('WhichKeySeparator', { fg = c.slate2 })
hi('WhichKeyFloat',     { bg = c.bg1 })
hi('WhichKeyBorder',    { fg = c.bg4, bg = c.bg1 })

-- ── Illuminate ────────────────────────────────────────────────────────────────
hi('IlluminatedWordText',  { bg = c.bg4 })
hi('IlluminatedWordRead',  { bg = c.bg4 })
hi('IlluminatedWordWrite', { bg = c.bg4, bold = true })

-- ── Indent blankline ──────────────────────────────────────────────────────────
hi('IblIndent', { fg = c.bg3 })
hi('IblScope',  { fg = c.bg4 })

-- ── Noice ─────────────────────────────────────────────────────────────────────
hi('NoiceCmdlineIcon',        { fg = c.slate4 })
hi('NoiceCmdlinePopup',       { fg = c.fg,   bg = c.bg1 })
hi('NoiceCmdlinePopupBorder', { fg = c.bg4,  bg = c.bg1 })
hi('NoiceConfirmBorder',      { fg = c.bg4,  bg = c.bg1 })

-- ── nvim-notify ───────────────────────────────────────────────────────────────
hi('NotifyERRORBorder', { fg = c.slate0 })
hi('NotifyWARNBorder',  { fg = c.slate0 })
hi('NotifyINFOBorder',  { fg = c.slate0 })
hi('NotifyDEBUGBorder', { fg = c.slate0 })
hi('NotifyTRACEBorder', { fg = c.slate0 })
hi('NotifyERRORTitle',  { fg = c.fg_bright })
hi('NotifyWARNTitle',   { fg = c.slate7 })
hi('NotifyINFOTitle',   { fg = c.slate4 })
hi('NotifyDEBUGTitle',  { fg = c.muted })
hi('NotifyTRACETitle',  { fg = c.muted })
hi('NotifyERRORIcon',   { fg = c.fg_bright })
hi('NotifyWARNIcon',    { fg = c.slate7 })
hi('NotifyINFOIcon',    { fg = c.slate4 })
hi('NotifyDEBUGIcon',   { fg = c.muted })
hi('NotifyTRACEIcon',   { fg = c.muted })

-- ── Alpha dashboard ───────────────────────────────────────────────────────────
hi('AlphaHeader',  { fg = c.slate4 })
hi('AlphaButtons', { fg = c.fg_dim })
hi('AlphaFooter',  { fg = c.muted, italic = true })

-- ── Scrollbar ─────────────────────────────────────────────────────────────────
hi('ScrollbarHandle', { bg = c.bg3 })

-- ── Todo comments ─────────────────────────────────────────────────────────────
hi('TodoBgTODO',   { fg = c.bg,  bg = c.slate4, bold = true })
hi('TodoBgFIX',    { fg = c.bg,  bg = c.fg_bright, bold = true })
hi('TodoBgHACK',   { fg = c.bg,  bg = c.slate6, bold = true })
hi('TodoBgNOTE',   { fg = c.bg,  bg = c.muted,  bold = true })
hi('TodoBgPERF',   { fg = c.bg,  bg = c.slate3, bold = true })
hi('TodoFgTODO',   { fg = c.slate4 })
hi('TodoFgFIX',    { fg = c.fg_bright })
hi('TodoFgHACK',   { fg = c.slate6 })
hi('TodoFgNOTE',   { fg = c.muted })
hi('TodoFgPERF',   { fg = c.slate3 })
