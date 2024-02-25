#!/bin/bash
# Originally used in a challenge that involved cronjobs that I ended up removing.

# Path to the cronjob file
CRONJOB_FILE="/etc/crontab"

# Path to the script to be modified
CRONJOB_SCRIPT="/home/level10/cronjob.sh"

# Contents to replace the script with
MODIFIED_CONTENT="ping -c 5 localhost"

# Variable to store the previous execution time
PREV_EXEC_TIME=""

# Function to get the latest execution time of the cronjob
get_latest_exec_time() {
    # Get the latest execution time from the system logs
    EXEC_TIME=$(grep "CMD (/bin/bash /home/level10/cronjob.sh" /var/log/syslog | tail -n 1 | awk '{print $1, $2, $3}')
    if [ ! -z "$EXEC_TIME" ] && [ "$EXEC_TIME" != "$PREV_EXEC_TIME" ]; then
        PREV_EXEC_TIME="$EXEC_TIME"
	echo "Execution time changed, updating cronjob.sh"
	return 0  # Success, execution time changed
    else
	echo "No change in execution time"
        return 1  # No change in execution time
    fi
}

# Function to modify the script if cronjob has executed again
modify_script() {
    echo "$MODIFIED_CONTENT" > "$CRONJOB_SCRIPT"
}

# Main loop to continuously monitor cronjob execution
while true; do
    if get_latest_exec_time; then
        modify_script
    fi
    sleep 10  # Adjust the sleep duration as needed
done

