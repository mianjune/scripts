#!/bin/bash

# alias echo for color escape
echo "\033[0m" | grep -q 033 && { alias echo="echo -e"; }

# check is executing just by proccess's name
ps -ef|grep `basename $0`|grep -v "$$"|grep -v grep && {
    echo "\e[31mShell($0) is executing\e[0m";
    exit 1;
}



dest_host=remote-server.com
dest_dir=/remote/server/path

base_dir="$HOME"
backup_dir="
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


echo "\e[32mStart Rsync \e[33m${base_dir} ...\e[0m" &&\
    cd $base_dir || exit 1

excludes=`echo "$exclude_path" | grep -oE '^[^#]+' | xargs -I {} echo "--exclude={}"`
includes=`echo "$include_path" | grep -oE '^[^#]+' | xargs -I {} echo "--include={}"`
backups=`echo "$backup_dir" | grep -oE '^[^#]+' | xargs echo`

echo rsync -n -vzahPR --delete-after $excludes $includes $backups ${dest_host}:$dest_dir
     rsync    -vzahPR --delete-after $excludes $includes $backups ${dest_host}:$dest_dir

