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
unset EmacsPath

FijiPath='/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx'
set_alias_if_exists $FijiPath fiji "$FijiPath"
unset FijiPath

set_alias_if_exists emacs ez 'emacs ~/.zshrc'

if command -v lsd &>/dev/null; then
    alias ls='lsd'
    alias lsn='lsd -v'
else
    alias ls='/bin/ls -G -F --color=auto'
fi

alias c="clear"
alias e="exit"
alias l='ls -lAh'
alias la='ls -A'
alias lt='ls -t'
alias lat='ls -At'
alias ll='ls -lh'
alias llt='ls -lt'
alias llat='ls -lAt'
alias -g G="| grep -i --color=auto"
alias o.="open ."
alias remake="make clean && make"
alias sz='source ~/.zshrc'

if [ -f "$HOME/.config/kitty/kitty.conf" ]; then
    alias ek='emacs $HOME/.config/kitty/kitty.conf'
    alias ck='code $HOME/.config/kitty/kitty.conf'
fi

# direnv
set_alias_if_exists direnv da 'direnv allow'

# tree
set_alias_if_exists tree tree 'tree -a -I "\.DS_Store|\.git|\.venv"'

# vscode
set_alias_if_exists code cz 'code ~/.zsh'
set_alias_if_exists code c. 'code .'

# nvim
set_alias_if_exists nvim nz 'nvim ~/.zsh'
set_alias_if_exists nvim n. 'nvim .'

set_alias_if_exists icdiff diff 'icdiff -H -N'
# alias diff="icdiff -H -N"

# fd
set_alias_if_exists fd fd 'fd -E "CloudStorage"'

# man likeなコマンド
set_alias_if_exists tldr tldr 'tldr --pager'

# 進化版cat
set_alias_if_exists batcat bat 'batcat'
set_alias_if_exists bat less 'bat --plain'

# btm option
set_alias_if_exists btm btm 'btm --theme default-light'

# lazygit
set_alias_if_exists lazygit lz 'lazygit'

[ -n "`alias run-help`" ] && unalias run-help

# ssh for kitty
if [[ "$TERM" == "xterm-kitty" ]]; then
    alias ssh="kitten ssh"
fi
