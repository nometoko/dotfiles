export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<'
export EDITOR='vim'

# 以下の拡張子を持つファイルは保管候補に出さない
fignore=(.o .aux .log .bbl .blg .lof .dvi .fls .fdb_latexmk .synctex.gz .lot .toc .out .a\~)

if [ -d /usr/libexec/java_home ]; then
    export JAVA_HOME=`/usr/libexec/java_home`
fi

# for lf command
if [ -d /Applications/LibreOffice.app/Contents/MacOS ]; then
    export PATH=$PATH:/Applications/LibreOffice.app/Contents/MacOS
fi

if [ -d $HOME/bin ]; then
    export PATH=$PATH:$HOME/bin
fi

# for bat command
if [ -n "`command -v bat 2>&1`" ]; then
    if [[ "$TERM" == "xterm-256color" ]]; then
        export BAT_THEME='GitHub'
    elif [[ "$TERM" == "xterm-kitty" ]]; then
        export BAT_THEME='MyTheme'
    fi
fi

# for fzf command
if [ -n "`command -v fzf 2>&1`" ]; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --exclude .git --exclude .venv --exclude "CloudStorage"'
    export FZF_DEFAULT_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}" --delimiter / --nth -1'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND -H"
    export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}" --delimiter '/' --nth -1'
fi

if [ -d $HOME/Library/Mobile\ Documents ]; then
    export ICLOUD_PATH=$HOME/Library/Mobile\ Documents
fi

# for X11
if [ -z $DISPLAY ]; then
    export DISPLAY=:0
fi

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
    export PKG_CONFIG_PATH=/opt/local/lib/pkgconfig
fi

if [ -d /opt/local/lib/opencv4/pkgconfig ]; then
    export PKG_CONFIG_PATH=/opt/local/lib/opencv4/pkgconfig:$PKG_CONFIG_PATH
fi

if [ -d $HOME/pkgconfig ]; then
    export PKG_CONFIG_PATH=$HOME/pkgconfig:$PKG_CONFIG_PATH
fi

if [ `uname` = "Darwin" ]; then
    export CPATH=/opt/local/include:$CPATH
    export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib:$DYLD_FALLBACK_LIBRARY_PATH
fi

if [ -d $HOME/.config/starship ]; then
    export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
fi

if [ -d $HOME/.cargo/bin ]; then
    export PATH=$PATH:$HOME/.cargo/bin
fi
