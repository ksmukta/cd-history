cd(){
    command cd $@
    cd_history_index=$((cd_history_index+1))
    if [[ "${cd_history[$cd_history_index]}" != "$PWD" ]]; then
        cd_history=("${cd_history[@]:0:$cd_history_index}")
        cd_history[$cd_history_index]=$PWD
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
cd_history=("$PWD")
cd_history_index=0
