#!/bin/bash

DATA="data/diary.csv"
LOG="logs/activity.log"

# Function to write activity log
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG"
}

# Check whether data file exists
check_data() {
    if [ ! -f "$DATA" ]; then
        echo "Diary file not found!"
        exit 1
    fi
}

# Help menu
show_help() {
    echo "Internship Diary Help"
    echo "Run ./main.sh to open the menu"
    echo "Run ./main.sh --backup to create backup"
    echo "Run ./main.sh --cron to generate weekly report"
}

# View diary data
view_data() {
    check_data
    cat "$DATA"
}

# Backup diary data
do_backup() {
    mkdir -p backups
    tar -czf "backups/data_$(date +%Y%m%d_%H%M%S).tar.gz" data/
    echo "Backup created successfully!"
    log "Backup created"
}

# View activity log
view_log() {
    if [ -f "$LOG" ]; then
        cat "$LOG"
    else
        echo "No activity log found."
    fi
}

# Feature 1: Add today's entry
feature_1() {
    read -p "Enter hours worked: " hours
    if ! [[ "$hours" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
        echo "Invalid hours!"
        return
    fi

    read -p "Enter task description: " task
    if [ -z "$task" ]; then
        echo "Task cannot be empty!"
        return
    fi

    echo "$(date +%F),$hours,$task" >> "$DATA"
    echo "Entry added successfully!"
    log "New diary entry added"
}

# Feature 2: Total hours
feature_2() {
    awk -F, 'NR>1 {sum += $2} END {printf "Total hours: %.2f\n", sum}' "$DATA"
}

# Feature 3: Weekly summary
feature_3() {
    read -p "Enter start date (YYYY-MM-DD): " start
    read -p "Enter end date (YYYY-MM-DD): " end

    awk -F, -v s="$start" -v e="$end" '
    NR>1 && $1>=s && $1<=e {
        print
        sum += $2
    }
    END {
        printf "Total weekly hours: %.2f\n", sum
    }' "$DATA"
    log "Weekly summary generated"
}

# Feature 4: Search task
feature_4() {
    read -p "Enter keyword: " keyword
    if [ -z "$keyword" ]; then
        echo "Keyword cannot be empty!"
        return
    fi

    grep -i "$keyword" "$DATA"
    log "Diary searched"
}

# Feature 5: Export diary report
feature_5() {
    mkdir -p reports
    report="reports/diary_$(date +%Y%m%d).txt"

    printf "%-15s %-10s %s\n" "DATE" "HOURS" "TASK" > "$report"
    printf "%-15s %-10s %s\n" "---------------" "----------" "--------------------" >> "$report"

    awk -F, 'NR>1 {printf "%-15s %-10s %s\n", $1, $2, $3}' "$DATA" >> "$report"

    echo "Report saved to $report"
    log "Diary report exported"
}

feature_5() {
    check_data
    mkdir -p reports

    report="reports/diary_$(date +%Y%m%d).txt"

    printf "%-15s %-10s %s\n" "DATE" "HOURS" "TASK" > "$report"
    printf "%-15s %-10s %s\n" "---------------" "----------" "--------------------" >> "$report"

    tail -n +2 "$DATA" | sort -t, -k1,1 | awk -F, '
    {
        printf "%-15s %-10s %s\n", $1, $2, $3
    }' >> "$report"

    echo "Report saved to $report"
    log "Diary report exported"
}

cron_task() {
    mkdir -p reports

    start=$(date -d '6 days ago' +%F)
    end=$(date +%F)

    report="reports/week_$(date +%F).txt"

    echo "WEEKLY INTERNSHIP DIARY REPORT" > "$report"
    echo "From: $start To: $end" >> "$report"
    echo "----------------------------------------" >> "$report"

    awk -F, -v s="$start" -v e="$end" '
    NR>1 && $1>=s && $1<=e {
        printf "%-15s %-10s %s\n", $1, $2, $3
        sum += $2
    }
    END {
        printf "\nTotal weekly hours: %.2f\n", sum
    }' "$DATA" >> "$report"

    log "Weekly cron report generated"

    echo "Weekly report generated successfully!"
    echo "Report saved to: $report"
}
