#!/bin/bash

cd "$(dirname "$0")"

source lib/functions.sh

# Command line options
case "$1" in
    --help)
        show_help
        exit 0
        ;;
    --backup)
        do_backup
        exit 0
        ;;
    --cron)
        cron_task
        exit 0
        ;;
esac

# Main menu
while true
do
    echo ""
    echo "================================"
    echo "       INTERNSHIP DIARY"
    echo "================================"
    echo "1. Add Today's Entry"
    echo "2. Show Total Hours"
    echo "3. Weekly Summary"
    echo "4. Search Tasks"
    echo "5. Export Diary Report"
    echo "6. View All Diary Data"
    echo "7. Backup Data"
    echo "8. View Activity Log"
    echo "0. Exit"
    echo "================================"

    read -p "Enter your choice: " choice

    case "$choice" in
        1) feature_1 ;;
        2) feature_2 ;;
        3) feature_3 ;;
        4) feature_4 ;;
        5) feature_5 ;;
        6) view_data ;;
        7) do_backup ;;
        8) view_log ;;
        0)
            echo "Thank you for using Internship Diary!"
            exit 0
            ;;
        *)
            echo "Invalid choice! Please try again."
            ;;
    esac
done
