# L66 – Internship Diary

## Project Information

- **Project Name:** Internship Diary
- **Student Name:** Nahiyan Shaikh
- **Roll Number:** H41
- **Division:** H

## 1. Problem Statement

The Internship Diary is a Linux-based application developed using Bash Shell Scripting. It helps students maintain their daily internship activities, record working hours, calculate total hours, and generate weekly reports.

## 2. Who Will Use It?

Students doing internships who need to maintain and submit a daily activity logbook.

## 3. Folder Structure

```text
interndiary/
│
├── main.sh
├── README.md
│
├── data/
│   └── diary.csv
│
├── lib/
│   └── functions.sh
│
├── backups/
│
├── logs/
│   └── activity.log
│
└── reports/
    ├── diary_20261103.txt
    └── week_2026-11-03.txt
```

- **main.sh:** Main program and menu.
- **README.md:** Project documentation.
- **data/:** Stores diary entries.
- **lib/:** Contains Bash functions.
- **backups/:** Stores compressed backup files.
- **logs/:** Stores activity logs.
- **reports/:** Stores generated reports.

## 4. Features

1. Add Today's Entry – Automatically records the current date, working hours, and task.
2. Show Total Hours – Calculates total working hours using AWK.
3. Weekly Summary – Displays entries and total hours for a selected date range.
4. Search Tasks – Searches diary entries using keywords and GREP.
5. Export Diary Report – Creates a formatted report using PRINTF.
6. View All Diary Data – Displays all stored diary entries.
7. Backup Data – Creates compressed backups using TAR.
8. View Activity Log – Displays recorded activities.
9. Automatic Weekly Report – Uses CRON to generate weekly reports every Friday at 7 PM.

## 5. Technologies and Commands Used

- Linux – Operating system environment.
- Bash Shell Scripting – Main programming language.
- DATE – Gets the current date and time.
- AWK – Calculates total working hours and generates summaries.
- GREP – Searches tasks by keyword.
- PRINTF – Formats report output.
- SORT – Used for sorting data.
- TAR – Creates compressed backups.
- CRON – Automates weekly report generation.
- NANO – Edits project files.

## 6. How to Run the Project

Open the terminal and navigate to the project folder:

```bash
cd ~/linux_project/interndiary
```

Give execution permission:

```bash
chmod +x main.sh
```

Run the application:

```bash
./main.sh
```

To display help:

```bash
./main.sh --help
```

To create a backup:

```bash
./main.sh --backup
```

To generate a weekly report manually:

```bash
./main.sh --cron
```

## 7. Cron Job Configuration

My Cron job:

```bash
0 19 * * 5 /bin/bash /home/dell/linux_project/interndiary/main.sh --cron >> /home/dell/linux_project/interndiary/logs/cron.log 2>&1
```

### Explanation of the five fields

- 0 – Minute (00)
- 19 – Hour (7 PM)
- * – Every day of the month
- * – Every month
- 5 – Friday

This Cron job automatically runs the weekly report function every Friday at 7 PM.

## 8. What I Learned

1. Learned basic Linux commands and directory management.
2. Learned Bash Shell Scripting and functions.
3. Learned how to use AWK and GREP for data processing.
4. Learned how to create compressed backups using TAR.
5. Learned how to automate tasks using CRON.

## 9. Conclusion

The Internship Diary project helped me understand Linux commands, shell scripting, file handling, data processing, backup management, and task automation. It provides a simple way for students to maintain their internship records and generate reports.
