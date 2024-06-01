IGNORE_PATTERN="^\.(git|travis|DS_Store)"

# シンボリックリンクの作成
# ホームディレクトリ直下に作成する
for dotfile in .??*; do
        [[ $dotfile =~ $IGNORE_PATTERN ]] && continue
        ln -snvf "$HOME/dotfiles/$dotfile" ~
done
