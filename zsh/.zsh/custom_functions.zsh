# ジョブが終わったら通知
# usage % executeCommend ; done-notify
done-notify() {
  local var=$(echo $history[$HISTCMD] | sed -e "s/$0//" -e 's/ *; *//' -e 's/ *&& *//')
  osascript -e 'display notification "'"$var finished!"'" with title "Terminal"'
}

show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}

# fd - cd to selected directory
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -name "Library" -prune -o -name "Pictures" -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

subst-transparent(){
  filename="$1"
  python ~/illustlation/substTransparent.py -f "$1"
  tmpFilename="${filename%.*}_withBG.${filename#*.}"
  filename_pdf="${filename%.*}.pdf"
  convert $tmpFilename $filename_pdf
  rm $tmpFilename
}

get-contours(){
  filename="$1"
  python ~/illustlation/makeContours.py -f "$1"
  tmpFilename="${filename%.*}_Contours.${filename#*.}"
  filename_pdf="${filename%.*}_Contours.pdf"
  convert $tmpFilename $filename_pdf
  rm $tmpFilename
}

del(){
  delFilename=$1
  mv $1 ~/.Trash/
}

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

replace-space-rec(){
  # 変換対象ディレクトリを指定（デフォルトはカレントディレクトリ）

# ディレクトリ内の全てのファイルとディレクトリを検索し、スペースをアンダーバーに置換
  find . | while IFS= read -r file; do
    # 新しいファイル/ディレクトリ名を作成（スペースをアンダーバーに置換）
    new_file=$(echo "$file" | tr ' ' '_')
    
    # 名前に変更がある場合のみ、名前を変更
    if [[ "$file" != "$new_file" ]]; then
      mv "$file" "$new_file"
      echo "Renamed: '$file' -> '$new_file'"
    fi
done
}
