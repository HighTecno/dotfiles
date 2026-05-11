local ok, telescope = pcall(require, 'telescope')
if not ok then return end

local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    prompt_prefix   = '   ',
    selection_caret = ' ',
    entry_prefix    = '  ',
    multi_icon      = ' ',
    path_display    = { 'truncate' },
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = { prompt_position = 'top', preview_width = 0.55 },
      vertical   = { mirror = false },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = {
      i = {
        ['<C-n>']   = actions.cycle_history_next,
        ['<C-p>']   = actions.cycle_history_prev,
        ['<C-j>']   = actions.move_selection_next,
        ['<C-k>']   = actions.move_selection_previous,
        ['<C-c>']   = actions.close,
        ['<Down>']  = actions.move_selection_next,
        ['<Up>']    = actions.move_selection_previous,
        ['<CR>']    = actions.select_default,
        ['<C-x>']   = actions.select_horizontal,
        ['<C-v>']   = actions.select_vertical,
        ['<C-t>']   = actions.select_tab,
        ['<C-u>']   = actions.preview_scrolling_up,
        ['<C-d>']   = actions.preview_scrolling_down,
        ['<C-q>']   = actions.send_to_qflist + actions.open_qflist,
        ['<M-q>']   = actions.send_selected_to_qflist + actions.open_qflist,
        ['<Tab>']   = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
      },
      n = {
        ['<esc>'] = actions.close,
        ['q']     = actions.close,
        ['<CR>']  = actions.select_default,
        ['<C-x>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['<C-t>'] = actions.select_tab,
        ['<Tab>']   = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['j']  = actions.move_selection_next,
        ['k']  = actions.move_selection_previous,
        ['H']  = actions.move_to_top,
        ['M']  = actions.move_to_middle,
        ['L']  = actions.move_to_bottom,
        ['gg'] = actions.move_to_top,
        ['G']  = actions.move_to_bottom,
        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-d>'] = actions.preview_scrolling_down,
      },
    },
  },
  pickers = {
    find_files = { hidden = true, follow = true },
    live_grep  = { additional_args = { '--hidden' } },
    buffers    = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = { i = { ['<C-d>'] = actions.delete_buffer } },
    },
    colorscheme = { enable_preview = true },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
})

-- Load extensions (graceful — only if compiled)
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')
pcall(telescope.load_extension, 'noice')

local builtin = require('telescope.builtin')
local map = vim.keymap.set

-- Files
map('n', '<leader>ff', builtin.find_files,                      { desc = 'Find files' })
map('n', '<leader>fr', builtin.oldfiles,                        { desc = 'Recent files' })
map('n', '<leader>fb', builtin.buffers,                         { desc = 'Find buffers' })
map('n', '<leader>fn', function()
  builtin.find_files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Find in config' })

-- Search
map('n', '<leader>fg', builtin.live_grep,                       { desc = 'Live grep' })
map('n', '<leader>fw', builtin.grep_string,                     { desc = 'Grep word' })
map('n', '<leader>f/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = 'Fuzzy buffer' })

-- Git
map('n', '<leader>gc', builtin.git_commits,     { desc = 'Git commits' })
map('n', '<leader>gB', builtin.git_branches,    { desc = 'Git branches' })
map('n', '<leader>gs', builtin.git_status,      { desc = 'Git status' })
map('n', '<leader>gS', builtin.git_stash,       { desc = 'Git stash' })

-- LSP
map('n', '<leader>fs', builtin.lsp_document_symbols,   { desc = 'Document symbols' })
map('n', '<leader>fS', builtin.lsp_workspace_symbols,  { desc = 'Workspace symbols' })
map('n', '<leader>fd', builtin.diagnostics,             { desc = 'Diagnostics' })

-- Meta
map('n', '<leader>fh', builtin.help_tags,               { desc = 'Help tags' })
map('n', '<leader>fk', builtin.keymaps,                 { desc = 'Keymaps' })
map('n', '<leader>fc', builtin.colorscheme,             { desc = 'Colorschemes' })
map('n', '<leader>fo', builtin.vim_options,             { desc = 'Options' })
map('n', '<leader>fC', builtin.commands,                { desc = 'Commands' })
map('n', '<leader>f:', builtin.command_history,         { desc = 'Command history' })
map('n', '<leader>fm', builtin.marks,                   { desc = 'Marks' })
map('n', '<leader>f"', builtin.registers,               { desc = 'Registers' })
