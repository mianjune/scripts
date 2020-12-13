#!/bin/sh

# alias echo for color escape
echo "\033[0m" | grep -q 033 && { alias echo="echo -e"; }

get_start() {
    echo "walk-gits.sh v1.0 by Mianjune
    A script for Git respositoy executing command in batches

Usage: \e[32m$0 COMMAND REPOSITORY_PATHs...\e[0m

Examples:
    \e[32m$0 'git fetch' ~/Documents/works
    $0 'git pull' ~/Documents/github"
}

if [ $# -eq 0 ]; then get_start; exit 0; fi
for a in $@; do
    [ $a == '-h' -o $a == '--help' ] && { get_start; exit 0; }
done



# check is executing just by proccess's name
# TODO: atomic checking
ps -ef|grep `basename $0`|grep -v "$$"|grep -v grep && {
    echo "\e[31mShell($0) is executing\e[0m"; exit 1;
}



# Find all Git in argument directories and execute Git update
foreach_dir() {
    cmd=$1; shift
    for dir in $@; do
        dir=`realpath $dir`
        echo "\e[1;32m[\033[36m`date +%H:%M:%S`\e[1;32m] Finding Git from \e[34m$dir\e[1;32m ... \t\e[0m"

        find $dir -name .git -type d 2>/dev/null | xargs -r dirname | while read repository; do
            echo "\e[1;32m[\033[36m`date +%H:%M:%S`\e[1;32m]\t\e[1;33m${cmd} \e[1;31m$repository\e[1;33m ...\e[0m"
            cd $repository && $cmd 0<&-
        done
    done
}



arg1=$1; shift
foreach_dir "$arg1" $@

## Examples
# git_dir=(
#     ~/Documents
#     ~/Documents/projects
#     ~/Documents/gits
# )
# 
# foreach_dir ${git_dir[@]}

# foreach_dir \
#     ~/Documents \
#     ~/Documents/projects \
#     ~/Documents/gits

