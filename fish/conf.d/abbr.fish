if status --is-interactive
  set -g fish_user_abbreviations

  abbr g git
  abbr b bundle
  abbr be 'bundle exec'
  abbr bi 'bundle install'
  abbr railsc 'bin/rails c'
  abbr spec 'bin/rspec'
  abbr v vim
  abbr vi vim
  abbr clr clear
  abbr t tmux
  abbr local_prune 'git branch >/tmp/merged-branches; vim /tmp/merged-branches; xargs git branch -d </tmp/merged-branches'
  abbr push 'git push -u origin --force-with-lease'
  abbr gg 'git grep'
  abbr gwatch "fswatch -o . -l 1 | xargs -IX sh -c 'clear; go test ./...'"
  abbr tm tomato
end

