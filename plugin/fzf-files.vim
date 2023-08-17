vim9script
##                 ##
# ::: Fzf Files ::: #
##                 ##

import 'fzf-run.vim' as Fzf

var spec = {
  'set_fzf_data': (data) =>
    system('fd --type=file --no-ignore --color=always .')
      ->split('\n')
      ->writefile(data),

  'set_tmp_file': ( ) => tempname(),
  'set_tmp_data': ( ) => tempname(),

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
    '--bind=alt-j:preview-down,alt-k:preview-up,alt-p:toggle-preview',
    '--expect=enter,ctrl-t,ctrl-s,ctrl-v'
  ],

  'set_term_command_options': (data) =>
    [ $"--bind=start:reload^cat '{data}'^" ],

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
