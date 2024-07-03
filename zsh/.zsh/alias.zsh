alias sz="source ~/.zshrc"
alias ez="emacs ~/.zshrc"
alias cz="code ~/.zshrc"
alias emacs="/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs -nw"
alias ls="ls -G -F"
alias history=" omz_history"       # don't save history to .zsh_history
alias diff="icdiff -H -N"
alias jupyter="/opt/local/bin/jupyter-lab-3.11"
alias venv="source ./.venv/bin/activate"
alias c="clear"
alias fiji='/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx'
alias da='direnv allow'
alias la='ls -a'
alias tree='tree -a -I "\.DS.Store|\.git|\.venv"'
alias fz="fzf-noempty --bind 'tab:toggle,shift-tab:toggle+beginning-of-line+kill-line,ctrl-j:toggle+beginning-of-line+kill-line,ctrl-t:top' --color=light -1 -m"
alias fd='fd -E "CloudStorage"'
alias clean-DS_Store='fd -H .DS_Store -X rm -i'
# man likeなコマンド
alias tldr='tldr --pager'
alias cat='bat'
alias btm='btm --color default-light'
[ -n "`alias run-help`" ] && unalias run-help
