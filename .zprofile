_global_path=( \
    $HOME/bin \
    $HOME/bin/go/bin
    $HOME/.cargo/bin \
)

_macos_path=( \
    /opt/local/bin \
    /opt/local/sbin \
    /opt/local/libexec/gnubin \
    /Library/Frameworks/Python.framework/Versions/3.12/bin \
    /Applications/LibreOffice.app/Contents/MacOS \
)

if [[ "$OSTYPE" == darwin* ]]; then
    path=( $path $_macos_path $_global_path)
    export DYLD_FALLBACK_LIBRARY_PATH="/opt/local/lib"
    export CPATH="/opt/local/include"
else
    path=( $path $_global_path )
fi

unset _global_path
unset _macos_path
export PATH
