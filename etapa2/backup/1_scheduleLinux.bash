crontab -e
# backup diário às 3h da manhã
0 3 * * * pg_dump -U postgres -F c -f /backups/backup_$(date +\%F).dump bd2_atv2