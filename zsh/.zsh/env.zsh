export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<'

# 以下の拡張子を持つファイルは保管候補に出さない
fignore=(.o .aux .log .bbl .blg .lof .dvi .fls .fdb_latexmk .synctex.gz .lot .toc .out .a\~)

if [ -z $LS_COLORS ]; then
    export LSCOLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=01;31:*.ace=01;31:*.alz=01;31:*.apk=01;31:*.arc=01;31:*.arj=01;31:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cpio=01;31:*.crate=01;31:*.deb=01;31:*.drpm=01;31:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.egg=01;31:*.esd=01;31:*.gz=01;31:*.jar=01;31:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.pyz=01;31:*.rar=01;31:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tgz=01;31:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.udeb=01;31:*.war=01;31:*.whl=01;31:*.wim=01;31:*.xz=01;31:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:"
fi

if [ -d /usr/libexec/java_home ]; then
    export JAVA_HOME=`/usr/libexec/java_home`
fi

# for lf command
if [ -d /Applications/LibreOffice.app/Contents/MacOS ]; then
    export PATH=$PATH:/Applications/LibreOffice.app/Contents/MacOS
fi

if [ -d $HOME/bin ]; then
    export PATH=$PATH:/$HOME/bin
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

