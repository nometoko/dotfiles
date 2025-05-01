# ジョブが終わったら通知
# usage % executeCommend ; done-notify
done-notify() {
  local var=$(echo $history[$HISTCMD] | sed -e "s/$0//" -e 's/ *; *//' -e 's/ *&& *//')
  osascript -e 'display notification "'"$var finished!"'" with title "Terminal"'
}

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

venv () {
    local venv_array=($HOME/venvs/*(/onN:t))
    if [ $#venv_array = 0 ]; then
        echo "No backup directory found"
        return 1
    fi
    for ((i = 1; i <= $#venv_array; i++)) print -r -- "[$i] $venv_array[$i]"

    read "index?Select index: "

    if [[ "$index" =~ '^[0-9]+$' ]]; then
        if [ $index -gt $#venv_array ]; then
            echo "Invalid index"
            return 1
        fi
        venv_name=${venv_array[$index]}
        echo "Activate $venv_name"
        source $HOME/venvs/$venv_name/bin/activate
    else
        echo "Invalid index"
    fi
    return 0
}

# どこのGPUが空いているか in funalab
nvistat() {
  servers=("v102" "v106" "v107")
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

chpwd() {
	if [ "$(pwd)" != $HOME ]; then
        if [ $(find . -maxdepth 1 -type f | wc -l) -le 100 ]; then
            ls -a
        else
            echo "too many files to show"
        fi
	fi
}

preexec() {
    tmp=RANDOM
    if (( tmp % 100 == 0 )); then
        echo "三藤だけはまじで、、、"
    else
        if (( tmp % 5 == 0)); then
            echo "今田翔から逃れることはできない、、、"
        fi
    fi
}

cat() {
    BAT_PAGET_TMP=$BAT_PAGER
    export BAT_PAGER=""
    bat --plain $1
    export BAT_PAGER=$BAT_PAGET_TMP
    unset BAT_PAGET_TMP
}
