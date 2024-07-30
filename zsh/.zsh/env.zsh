export JAVA_HOME=`/usr/libexec/java_home`
# for lf command
export PATH=$PATH:/Applications/LibreOffice.app/Contents/MacOS
# for bat command
export BAT_THEME='GitHub'
# for fzf command
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --exclude .git --exclude .venv --exclude "CloudStorage"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
export ICLOUD_PATH=$HOME/Library/Mobile\ Documents
# for X11
export DISPLAY=:0
# preamble file path for LaTeX
export TEXINPUTS=.:$HOME/tex:
# zcompdump file path
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
# for pkg-config (opencv4)
export PKG_CONFIG_PATH="/opt/local/lib/pkg-config:/opt/local/lib/opencv4/pkgconfig"
