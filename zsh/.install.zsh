mkdir -p ~/bin
export PATH="$PATH:$HOME/bin"

if ! command -v starship >/dev/null 2>&1; then
    echo "starship is not installed. Installing..."
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/bin --yes
fi

if ! command -v sheldon >/dev/null 2>&1; then
    echo "sheldon is not installed. Installing..."
    # x86_64, aarch64, armv7, x86_64-apple-darwin
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh | bash -s -- --repo rossmacarthur/sheldon --to ~/bin
fi

export CARGO_HOME="${HOME}/.cargo"
export RUSTUP_HOME="${HOME}/.rustup"
export PATH="${PATH}:${CARGO_HOME}/bin"

if ! command -v cargo >/dev/null 2>&1; then
    echo "cargo is not installed. Installing..."
    curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain stable --profile default
fi


if ! command -v lsd >/dev/null 2>&1; then
    echo "lsd is not installed. Installing..."
    cargo install lsd
fi
