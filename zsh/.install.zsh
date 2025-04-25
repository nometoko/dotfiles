if not command -v starship &>/dev/null; then
    echo "Starship is not installed. Installing..."
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/bin --yes
fi

if not command -v sheldon &> /dev/null; then
    echo "Sheldon is not installed. Installing..."
    # x86_64, aarch64, armv7, x86_64-apple-darwin
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh | bash -s -- --repo rossmacarthur/sheldon --to ~/bin
fi
