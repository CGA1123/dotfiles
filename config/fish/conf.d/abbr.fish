if status --is-interactive
  set -g fish_user_abbreviations

  abbr g git
  abbr b bundle
  abbr be 'bundle exec'
  abbr bi 'bundle install'
  abbr v vim
  abbr clr clear
  abbr t tmux
  abbr local_prune 'git branch >/tmp/merged-branches; vim /tmp/merged-branches; xargs git branch -D </tmp/merged-branches'
end
