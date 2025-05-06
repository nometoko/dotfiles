_macos_path=( \
    /opt/local/bin \
    /opt/local/sbin \
    /opt/local/libexec/gnubin \
    /Library/Frameworks/Python.framework/Versions/3.12/bin \
    /Applications/LibreOffice.app/Contents/MacOS \
)

if [[ "$OSTYPE" == darwin* ]]; then
    path=( $path $_macos_path )
fi

unset _macos_path
export PATH
