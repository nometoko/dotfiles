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
if [ -n "`command -v fzf 2>&1`" ]; then
  fcd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -name "Library" -prune -o -name "Pictures" -prune -o -type d -print 2> /dev/null | fzf +m --delimiter '/' --nth -1) &&
    cd "$dir"
  }
fi

# convert to pdf
topdf(){
  filename="$1"
  filename_pdf="${filename%.*}.pdf"
  convert $filename $filename_pdf
  rm $filename
}

del(){
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

venv () {
    local version="$1"
    if [ -z "$version" ]; then
        echo "Usage: venv <version>"
        return 1
    fi

    local activate="$HOME/venvs/${version}utils/bin/activate"
    if [ -e "$activate" ]; then
        source "$activate"
    else
        echo "No venv for version ${version}"
    fi
}

# どこのGPUが空いているか in funalab
nvistat() {
  servers=("v106" "v107")
  foreach i in $servers
    echo "${fg_bold[green]}$i${reset_color}:"
    ssh -x $i nvidia-smi --query-gpu=index,name,utilization.gpu,utilization.memory --format=csv,noheader \
      | sed -e 's/NVIDIA //g' -e 's/Tesla //g' -e 's/ %/%/g' -e 's/Graphics Device/A100 80GB PCIe/g' -e "s/ 0%/ ${fg_bold[cyan]}0${reset_color}%/g" -e "s/ 100%/${fg_bold[red]} 100${reset_color}%/g" \
      | while IFS=, read -r id gpu load mem
        do
          printf "%4s %16s [%4s] [%4s]\n" "$id" "$gpu" "$load" "$mem"
        done
  end
}

shrinkpdf () {
	if [ $# -lt 1 ]
	then
		echo "Usage: $0 file.pdf"
		echo "  will shrink file.pdf"
		return
	fi
	out=${1:r}-s.pdf
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dPDFSETTINGS=/printer -sOutputFile=${out} $1
}

backup-nvim() {
  local timestamp=$(date "+%Y-%m-%d-%H%M")
  echo "Backup following directories"
  echo "  ~/.config/nvim      => ~/.config/nvim.${timestamp}"
  echo "  ~/.local/share/nvim => ~/.local/share/nvim.${timestamp}"
  echo "  ~/.local/state/nvim => ~/.local/state/nvim.${timestamp}"
  echo "  ~/.cache/nvim       => ~/.cache/nvim.${timestamp}"

  # required
  mv ~/.config/nvim ~/.config/nvim.${timestamp}

  # optional but recommended
  mv ~/.local/share/nvim ~/.local/share/nvim.${timestamp}
  mv ~/.local/state/nvim ~/.local/state/nvim.${timestamp}
  mv ~/.cache/nvim ~/.cache/nvim.${timestamp}
}

# Restore your backed up nvim config. Use the backup-nvim.zsh script to create the backup.
restore-nvim() {
  local backup_array=(${(f)"$(command ls -1d ~/.config/nvim.* | sort -nr | sed -e 's/.*nvim/nvim/')"})

  if [ $#backup_array = 0 ]; then
    echo "No backup directory found"
    return 1
  fi
  for ((i = 1; i <= $#backup_array; i++)) print -r -- "[$i] $backup_array[i]"

  # select backup directory
  echo ""
  echo -n "Select index: "
  re='^[0-9]+$'
  read index
  if ! [[ $index =~ $re ]] ; then
    echo "Error: Not a number"
    return 1
  fi
  if [ $index -gt $#backup_array ]; then
    echo "index must be less than $#backup_array"
    return 1
  fi
  if [ $index -lt 1 ]; then
    echo "index must be greater than 1"
    return 1
  fi
  local selected=$backup_array[$index]
  echo "Selected: $selected"
  local backup_config="$HOME/.config/$selected"
  local backup_share="$HOME/.local/share/$selected"
  local backup_state="$HOME/.local/state/$selected"
  local backup_cache="$HOME/.cache/$selected"

  if [ ! -d $backup_config -o ! -d $backup_share -o ! -d $backup_state -o ! -d $backup_cache ]; then
    echo "backup directory not found"
    return 1
  fi

  echo ""
  echo "Restore following directories"
  echo ""
  echo "  $backup_config      => ~/.config/nvim"
  echo "  $backup_share => ~/.local/share/nvim"
  echo "  $backup_state => ~/.local/state/nvim"
  echo "  $backup_cache       => ~/.cache/nvim"
  echo ""
  echo "This operation will overwrite the above directories."
  echo -n "Proceed? [y/N] "

  read yesno
  # execute
  if [ $yesno = "y" -o $yesno = "Y" ]; then
    if [ -d ~/.config//nvim ]; then
      rm -rf ~/.config/nvim
    fi
    if [ -d ~/.local/share/nvim ]; then
      rm -rf ~/.local/share/nvim
    fi
    if [ -d ~/.local/state/nvim ]; then
      rm -rf ~/.local/state/nvim
    fi
    if [ -d ~/.cache//nvim ]; then
      rm -rf ~/.cache/nvim
    fi
    mv $backup_config ~/.config/nvim
    mv $backup_share  ~/.local/share/nvim
    mv $backup_state  ~/.local/state/nvim
    mv $backup_cache  ~/.cache/nvim
  fi
}
