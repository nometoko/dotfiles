cargo_install() {
    local cmd="$1"
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "$cmd is not installed. Installing..."
        cargo install "$cmd"
    else
        echo "$cmd is already installed."
    fi
}

mkdir -p ~/bin

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

if ! command -v cargo >/dev/null 2>&1; then
    echo "cargo is not installed. Installing..."
    curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain stable --profile default
fi

if ! command -v go >/dev/null 2>&1; then
    echo "go is not installed. Installing..."
    target="https://go.dev/dl/go1.24.2.linux-amd64.tar.gz"
    tar_file="${HOME}/bin/$(basename $target)"
    wget -O $tar_file $target
    tar -C ${HOME}/bin -xzf $tar_file
    rm $tar_file
fi

cargo_install "lsd"
cargo_install "rg"

if ! command -v fzf >/dev/null 2>&1; then
    echo "fzf is not installed. Installing..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --bin
fi
