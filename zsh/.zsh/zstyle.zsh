zstyle ':completion:*default' menu select=1
zstyle ':completion:*' ignore-parents parent pwd ..    # ../ の後は今いるディレクトリを補間しない
zstyle ':completion:*:cd:*' ignore-parents parent pwd  # 補間候補にカレントディレクトリは含めない
zstyle ':completion:*' list-colors $LS_COLORS
