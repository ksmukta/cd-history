RED='\033[0;31m'
NC='\033[0m' # No Color

cd(){
    #Quotes to handle directories with spaces
    command cd "$@"
    #Don't do anything if PWD hasn't changed
    if [[ "${cd_history[$cd_history_index]}" != "$PWD" ]]; then
        cd_history_index=$((cd_history_index+1))
        if [[ "${cd_history[$cd_history_index]}" != "$PWD" ]]; then
            cd_history=("${cd_history[@]:0:$cd_history_index}")
            cd_history[$cd_history_index]=$PWD
        fi
    fi
}

_go_back_cd(){
    if (( cd_history_index>0 )); then
        cd_history_index=$((cd_history_index-1))
        command cd ${cd_history[$cd_history_index]}
    fi
}

_go_forward_cd(){
    if (( cd_history_index < ((${#cd_history[*]}-1)) )); then
        cd_history_index=$((cd_history_index+1))
        command cd ${cd_history[$cd_history_index]}
    fi
}

_print_cd_stack(){
    for i in ${!cd_history[@]}; do
	if [[ $i == $cd_history_index ]]; then
            echo -e "${RED}->${NC} ${cd_history[$i]}"
	else
            echo "   ${cd_history[$i]}"
	fi
    done
}

cd_history=("$PWD")
cd_history_index=0
