vim9script
##                 ##
# ::: Fzf Files ::: #
##                 ##

import 'fzf-run.vim' as Fzf

var spec = {
  'set_fzf_data': (data) =>
    system("find $PWD/*(N) -name '.?*' -prune -or -type f -printf '%f\t%h/\n' | sort --version-sort --key=1")
      ->split('\n')
      ->writefile(data),

  'set_tmp_file': ( ) => tempname(),
  'set_tmp_data': ( ) => tempname(),

  'geometry': {
    'width': 0.8,
    'height': 0.8
  },

  'commands': {
    'enter':  (entry) => $"edit {entry->split('\t')->reverse()->join('')}",
    'ctrl-t': (entry) => $"tabedit {entry->split('\t')->reverse()->join('')}",
    'ctrl-s': (entry) => $"split {entry->split('\t')->reverse()->join('')}",
    'ctrl-v': (entry) => $"vsplit {entry->split('\t')->reverse()->join('')}"
  },

  'term_command': [
    'fzf',
    '--no-multi',
    '--preview-window=border-left',
    '--preview=bat --color=always --style=numbers {2}{1}',
    '--ansi',
    '--delimiter=\t',
    '--tabstop=1',
    '--bind=alt-j:preview-down,alt-k:preview-up,alt-h:first,alt-e:last,alt-p:toggle-preview,alt-e:change-preview-window(right,90%|right,50%)',
    '--expect=enter,ctrl-t,ctrl-s,ctrl-v'
  ],

  'set_term_command_options': (data) =>
    [ $"--bind=start:reload^cat '{data}' | column --table --separator='\t' --output-separator='\t'^" ],

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
