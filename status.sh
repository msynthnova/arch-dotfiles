uptime_formatted=$(uptime | cut -d "," -f1  | cut -d " " -f4,5)
date_formatted=$(date "+%a %F %H:%M")
linux_version=$(uname -r | cut -d "-" -f1)

ram_info=$(free -m)
total_ram=$(echo "$ram_info" | awk '/^Mem:/{print $2}')
used_ram=$(echo "$ram_info" | awk '/^Mem:/{print $3}')

echo uptime $uptime_formatted "|" $linux_version "|" $used_ram"mib" "|" $date_formatted
