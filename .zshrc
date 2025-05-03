autoload -U colors compinit
autoload run-help
colors
compinit

eval `dircolors`

# for fzf
if [ -f /opt/local/share/fzf/shell/key-bindings.zsh ]; then
    builtin source /opt/local/share/fzf/shell/key-bindings.zsh
fi
if [ -f /opt/local/share/fzf/shell/completion.zsh ]; then
    builtin source /opt/local/share/fzf/shell/completion.zsh
fi


if command -v direnv &>/dev/null; then eval "$(direnv hook zsh)"; fi
if command -v zoxide &>/dev/null; then eval "$(zoxide init zsh)"; fi
# # eval "$(zoxide init zsh)"
if command -v gh &>/dev/null; then eval "$(gh completion -s zsh)"; fi
# # eval "$(gh completion -s zsh)"
if command -v thefuck &>/dev/null; then eval "$(thefuck --alias)"; fi
# # eval "$(thefuck --alias)"

alias bs='builin source'
# source function with zcompile (precompile)
source() {
    local input="$1"
    local cache="$input.zwc"
    # もしCacheがないか、古いキャッシュなら再度コンパイル
    if [[ ! -f "$cache" || "$input" -nt "$cache" ]]; then
        zcompile "$input"
    fi
    \builtin source "$@"
}

source ~/.path.zsh

for file in ~/.config/zsh/*.zsh; do
	source $file
done

if [ -f "$HOME/.$HOST.zsh" ]; then
    source "$HOME/.$HOST.zsh"
fi

if [[ "${OSTYPE}" == darwin* ]]; then
    source "$HOME/.local.zsh"
fi

if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

if command -v sheldon &>/dev/null; then
    eval "$(sheldon source)"
fi
