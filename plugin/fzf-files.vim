vim9script
##                 ##
# ::: Fzf Files ::: #
##                 ##

import 'fzf-run.vim' as Fzf

var spec = {
  'fzf_default_command': $FZF_DEFAULT_COMMAND,

  'set_fzf_data': ( ) => 'fd --type=file --no-ignore --color=always .',

  'set_fzf_command': (data) => $"{data} || exit 0",

  'set_tmp_file': ( ) => tempname(),

  'geometry': {
    'width': 0.8,
    'height': 0.8
  },

  'commands': {
    'enter':  (entry) => $"edit {entry}",
    'ctrl-t': (entry) => $"tabedit {entry}",
    'ctrl-s': (entry) => $"split {entry}",
    'ctrl-v': (entry) => $"vsplit {entry}"
  },

  'term_command': [
    'fzf',
    '--no-multi',
    '--preview-window=border-left',
    '--preview=bat --color=always --style=numbers {1}',
    '--ansi',
    '--bind=alt-j:preview-down,alt-k:preview-up',
    '--expect=enter,ctrl-t,ctrl-s,ctrl-v'
  ],

  'set_term_command_options': ( ) => [ ],

  'term_options': {
    'hidden': true,
    'out_io': 'file'
  },

  'popup_options': {
    'title': '─ ::: Fzf Files ::: ─',
    'border': [1, 1, 1, 1],
    'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└']
  }
}

command FzfFF Fzf.Run(spec)

# vim: set textwidth=80 colorcolumn=80:
