#!/bin/sh

# alias echo for color escape
echo "\033[0m" | grep -q 033 && { alias echo="echo -e"; }


get_start() {
    echo "redis-del.sh v1.0 by Mianjune
    A script for delete cluster Redis key by scan matching

Usage: \e[32m$0 HOST:PORT KEY_MATCH\e[0m

Examples:
    \e[32m$0 127.0.0.1:6379 'CACHE_*'
    \e[0m# for standalone
    \e[32mredis-cli -h 127.0.0.1 -p 6379 --scan --pattern 'CACHE_*' | xargs -r -l20 -I {} echo 'del {}' | redis-cli -h 127.0.0.1 -p 6379\e[0m"
    # or just add function redis_del to shell rc file
}

if [ ! $# -eq 2 ]; then get_start; exit 0; fi


### Redis delete(or just add to shell rc file)
redis_del() { # host:port 'key_pattern'
    local nodes key
    key=$2
    [ ${key} ] || { echo "\033[31mA key pattern required!!!\033[0m"; return; }

    nodes=($(redis-cli -c -h ${1%:*} -p ${1#*:} CLUSTER NODES | grep master | awk '{print $2}' | grep -oP '\S+:\d+'))

    echo "\033[32mRemove \033[31m$key\033[32m from \033[31mRedis: \033[33m$nodes\033[32m\033[0m"
    for n in ${nodes[@]}; do
        echo "\033[32mremove \033[31m$key\033[32m from \033[33m$n\033[32m...\033[0m"
        redis-cli -h ${n%:*} -p ${n#*:} --scan --pattern "$key" | xargs -r -l20 -I {} echo 'del {}' | tee >(cat) |redis-cli -h ${n%:*} -p ${n#*:} | awk '{printf "█";if(NR%50==0){printf "\t" NR "\r";}}' # awk '{printf "."}'
    done
}


redis_del "$@"

