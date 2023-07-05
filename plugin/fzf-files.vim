vim9script
##                 ##
# ::: Fzf Files ::: #
##                 ##

import 'fzf-run.vim' as Fzf

var spec = {
  'fzf_default_command': $FZF_DEFAULT_COMMAND,

  'fzf_data': ( ) => 'fd --type=file --color=always .',

  'fzf_command': (data) => $"{data} || exit 0",

  'tmp_file': ( ) => tempname(),

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
    '--expect=enter,ctrl-t,ctrl-s,ctrl-v'
  ],

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
