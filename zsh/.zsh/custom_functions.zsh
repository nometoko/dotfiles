# ジョブが終わったら通知
# usage % executeCommend ; done-notify
done-notify() {
  local var=$(echo $history[$HISTCMD] | sed -e "s/$0//" -e 's/ *; *//' -e 's/ *&& *//')
  osascript -e 'display notification "'"$var finished!"'" with title "Terminal"'
}

# for direnv
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
export PS1='$(show_virtual_env)'$PS1

# fd - cd to selected directory
if [ command -v fzf &>/dev/null 2>&1 ]; then
  fcd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -name "Library" -prune -o -name "Pictures" -prune -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
  }
fi

# convert to pdf
to-pdf(){
  filename="$1"
  filename_pdf="${filename%.*}.pdf"
  convert $filename $filename_pdf
  rm $filename
}

del(){
  delFilename=$1
  mv $1 ~/.Trash/
}

# pwd 直下のファイル名にスペースが含まれている場合、アンダーバーに置換
replace-space(){
  for file in "."/*; do
      # ファイル名にスペースが含まれているか確認
      if [[ "$file" == *" "* ]]; then
          # 新しいファイル名を作成（スペースをアンダーバーに置換）
          new_file=$(echo "$file" | tr ' ' '_')
        
          # ファイル名を変更
          mv "$file" "$new_file"
        
          # 変更結果を表示
          echo "Renamed: '$file' -> '$new_file'"
      fi
  done
}

venv(){
  if [ -e "./.venv/bin/activate" ]; then
    source ./.venv/bin/activate
  else
    python -m venv .venv
    source ./.venv/bin/activate
  fi
}
