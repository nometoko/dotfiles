export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000

if [ -d /usr/libexec/java_home ]; then
    export JAVA_HOME=`/usr/libexec/java_home`
fi

# for lf command
if [ -d /Applications/LibreOffice.app/Contents/MacOS ]; then
    export PATH=$PATH:/Applications/LibreOffice.app/Contents/MacOS
fi

# for bat command
if [ command -v bat &>/dev/null 2>&1 ]; then
    export BAT_THEME='GitHub'
fi

# for fzf command
if [ command -v fzf &>/dev/null 2>&1 ]; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --exclude .git --exclude .venv --exclude "CloudStorage"'
    export FZF_DEFAULT_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi


if [ -d $HOME/Library/Mobile\ Documents ]; then
    export ICLOUD_PATH=$HOME/Library/Mobile\ Documents
fi

# for X11
export DISPLAY=:0
# preamble file path for LaTeX
if [ -d $HOME/tex ]; then
    export TEXINPUTS=.:$HOME/tex:
fi

# zcompdump file path
if [ -n $ZSH ]; then
    export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
fi

# for pkg-config (opencv4)
if [ -d /opt/local/lib/pkgconfig ]; then
    export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig"
fi

if [ -d /opt/local/lib/opencv4/pkgconfig ]; then
    export PKG_CONFIG_PATH="/opt/local/lib/opencv4/pkgconfig:$PKG_CONFIG_PATH"
fi
