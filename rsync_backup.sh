#!/bin/sh

# alias echo for color escape
echo "\033[0m" | grep -q 033 && { alias echo="echo -e"; }

# check is executing just by proccess's name
ps -ef|grep `basename $0`|grep -v "$$"|grep -v grep && {
    echo "\e[31mShell($0) is executing\e[0m";
    exit 1;
}


remote_host=remote-server.com # [USER@]HOST
remote_path=/remote/server/path/ # endswith '/'

local_path="$HOME"
target_paths="
.bash*
.zsh*
.vim*
.git*
.config

bin
shell
backup

# Documents
# Downloads
# Pictures

.m2/settings.xml
"

include_path="
"

exclude_path="
# */logs/
*/target/
*/__pycache__/
*.pyc
*/.*.swp
*/nohup.out
*/.DS_Store
*/.~lock.*#

# .config/Code
# .config/google-chrome
# .config/libreoffice
"


echo "\e[32mStart Rsync \e[33m${local_path} ...\e[0m" &&\
    cd $local_path || exit 1

excludes=`echo "$exclude_path" | grep -oE '^[^#]+' | xargs -I {} echo "--exclude={}"`
includes=`echo "$include_path" | grep -oE '^[^#]+' | xargs -I {} echo "--include={}"`

# Sync local to remote server
from_paths=`echo "$target_paths" | grep -oE '^[^#]+' | xargs echo`
to_paths=${remote_host}:$remote_path

# Sync remote server to local, uncomment below
# from_paths=`echo "$target_paths" | grep -oE '^[^#]+' | xargs -I {} echo "${remote_host}:${remote_path}{}"`
# to_paths=$local_path

echo rsync -n -vzahPR --delete-after $excludes $includes $from_paths $to_paths
     rsync    -vzahPR --delete-after $excludes $includes $from_paths $to_paths

