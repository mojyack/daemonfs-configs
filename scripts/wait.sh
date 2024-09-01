# $1 name
wait_for_daemon() {
    state_file="$daemonsdir/$1/state"
    while true; do
        if [[ ! -e $state_file ]]; then
            echo "waiting for $1 to appear"
            sleep 1
            continue
        fi
        break
    done
    while true; do
        state=$(<$state_file)
        if [[ $state == "up" ]]; then
            return 0
        elif [[ $state == "down" || $state == "fail" ]]; then
            echo "daemon $1 downed"
            return 1
        fi
        sleep 1
    done
}
