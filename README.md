# My Scripts

- Script
  - [walk_gits](#walk_gits) - walking all Git respositoies and execute the same command 
  - [rsync_backup](rsync_backup.sh) - a `rsync` configure script in one file
  - [redis_del](redis_del.sh) - del Redis key by pattern for Redis Cluster

## [walk_gits](walk_gits.sh) - walking all Git respositoies and execute the same command 
Example, I want to keep my local respositoy in sync with remote respositoy:
```cron
*/20 10-23,0 * * * ~/bin/walk_gits.sh 'git pull' ~/Documents/github &> /tmp/cron-`whoami`-update_git.log &
*/20 10-23,0 * * * ~/bin/walk_gits.sh 'git fetch' ~/Documents/works &> /tmp/cron-`whoami`-update_git.log &

```

## [rsync_backup](rsync_backup.sh) - a `rsync` configure script in one file

## [redis_del](redis_del.sh) - del Redis key by pattern for Redis Cluster

