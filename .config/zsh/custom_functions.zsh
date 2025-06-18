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
    local venv_num=${#venv_array}

    local conda_env_array=()
    if [[ -n `command -v conda 2>&1` ]]; then
        conda_env_array=($(conda env list | awk '{print $1}' | grep -v '^#'))
    fi

    if [[ $(( $#venv_array + $#conda_env_array )) -eq 0 ]]; then
        echo "No venvs found"
        return 1
    fi

    echo '[0] quit'
    echo '----local venvs----'
    for ((i = 1; i <= $#venv_array; i++)) print -r -- "[$i] $venv_array[$i]"

    echo '----conda envs----'
    for ((i = 1; i <= $#conda_env_array; i++)) print -r -- "[$(( $i + $venv_num ))] $conda_env_array[$i]"

    read "index?Select index: "

    if [[ "$index" =~ '^[0-9]+$' ]]; then
        if [ $index = '0' ]; then
            return 0
        elif [ $index -gt $(( $#venv_array + $#conda_env_array )) ]; then
            echo "Invalid index"
            return 1
        fi
        env_name=${venv_array[$index]}
        echo "Activate $env_name"

        if [ $index -le $#venv_array ]; then
            source $HOME/venvs/$env_name/bin/activate
        else
            venv_name=${conda_env_array[$(( $index - $venv_num ))]}
            conda activate $venv_name
            alias deactivate='conda deactivate && unalias deactivate'
        fi

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
    local bat_pager_tmp=$BAT_PAGER
    BAT_PAGER=""
    bat --plain $1
    export BAT_PAGER=$bat_pager_tmp
    unset bat_pager_tmp
}

unlink() {
    # 引数すべて処理
    for arg in "$@"; do
        /bin/unlink "$arg"
    done
}

latexclean() {
    fine_basename=${1:r}
    rm -f $fine_basename.{aux,dvi,fdb_latexmk,fls,log,out,synctex.gz}
}
