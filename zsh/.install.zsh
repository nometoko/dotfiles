mkdir -p ~/bin
export PATH="$PATH:$HOME/bin"

if ! command -v starship >/dev/null 2>&1; then
    echo "Starship is not installed. Installing..."
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/bin --yes
fi

if ! command -v sheldon >/dev/null 2>&1; then
    echo "Sheldon is not installed. Installing..."
    # x86_64, aarch64, armv7, x86_64-apple-darwin
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh | bash -s -- --repo rossmacarthur/sheldon --to ~/bin
fi
