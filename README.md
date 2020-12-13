# My Script Backups

- Script
  - [walk_gits](#walk_gits) - walking all Git respositoies and execute the same command 

# [walk_gits](walk_gits.sh) - walking all Git respositoies and execute the same command 
I want to keep my local respositoy in sync with remote respositoy:
```cron
*/20 10-23,0 * * * ~/bin/walk_gits.sh 'git pull' ~/Documents/github &> /tmp/cron-`whoami`-update_git.log &
*/20 10-23,0 * * * ~/bin/walk_gits.sh 'git fetch' ~/Documents/works &> /tmp/cron-`whoami`-update_git.log &

```
