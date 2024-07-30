set_alias_if_exists() {
    command -v $1 >/dev/null 2>&1 && alias $2=$3
}

set_alias_if_path_exists() {
    if [ -e "$1" ]; then
        alias $2=$3
    fi
}

EmacsPath="/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs"
set_alias_if_path_exists $EmacsPath emacs "$EmacsPath -nw"
# alias emacs='/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs -nw'
unset EmacsPath

FijiPath='/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx'
set_alias_if_exists $FijiPath fiji "$FijiPath"
# alias fiji='/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx'
unset FijiPath


alias sz='source ~/.zshrc'
set_alias_if_exists emacs ez 'emacs ~/.zshrc'
# alias ez='emacs ~/.zshrc'

set_alias_if_exists omz_history history ' omz_history'
# alias history=" omz_history"       # don't save 'history' to .zsh_history

jupyterPath="/opt/local/bin/jupyter-lab-3.11"
set_alias_if_path_exists $jupyterPath jupyter "$jupyterPath"
# alias jupyter="/opt/local/bin/jupyter-lab-3.11"
unset jupyterPath


alias venv='source ./.venv/bin/activate'
alias c="clear"
alias ls="/bin/ls -G -F"
alias la='/bin/ls -G -F -a'

set_alias_if_exists direnv da 'direnv allow'
# alias da='direnv allow'
set_alias_if_exists tree tree 'tree -a -I "\.DS.Store|\.git|\.venv"'
# alias tree='tree -a -I "\.DS.Store|\.git|\.venv"'
set_alias_if_exists code cz 'code ~/.zshrc'
# alias cz="code ~/.zshrc"
set_alias_if_exists icdiff diff 'icdiff -H -N'
# alias diff="icdiff -H -N"
set_alias_if_exists fzf fz 'fzf-noempty --bind "tab:toggle,shift-tab:toggle+beginning-of-line+kill-line,ctrl-j:toggle+beginning-of-line+kill-line,ctrl-t:top" --color=light -1 -m'
# alias fz="fzf-noempty --bind 'tab:toggle,shift-tab:toggle+beginning-of-line+kill-line,ctrl-j:toggle+beginning-of-line+kill-line,ctrl-t:top' --color=light -1 -m"
set_alias_if_exists fd fd 'fd -E "CloudStorage"'
# alias fd='fd -E "CloudStorage"'
set_alias_if_exists fd clean-DS_Store 'fd -H .DS_Store -X rm -i'
# alias clean-DS_Store='fd -H .DS_Store -X rm -i'

# man likeなコマンド
set_alias_if_exists tldr tldr 'tldr --pager'
# alias tldr='tldr --pager'

# 進化版cat
set_alias_if_exists bat cat 'bat'
# alias cat='bat'

# btm option
set_alias_if_exists btm btm 'btm --color default-light'
# alias btm='btm --color default-light'

# lazygit
set_alias_if_exists lazygit lz 'lazygit'

[ -n "`alias run-help`" ] && unalias run-help
