export JAVA_HOME=`/usr/libexec/java_home`
export PATH=$PATH:/Applications/LibreOffice.app/Contents/MacOS
export BAT_THEME='GitHub'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --exclude .git --exclude .venv --exclude Library --exclude "Google Drive"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
export ICLOUD_PATH=$HOME/Library/Mobile\ Documents
