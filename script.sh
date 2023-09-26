#!/bin/bash

while true; do
  echo "Deletion process starting..."

  echo "Please choose one of the following options:"
  echo "1- Files created today."
  echo "2- Files created 1 month ago."
  echo "3- Files created 2 months ago."
  echo "4- Files created 3 months ago."
  echo "5- Files created 4 months ago."
  echo "6- Exit"
  read answer

  if [ "$answer" == "6" ]; then
    echo "Exiting the program."
    break
  fi

  if [ "$answer" == "1" ] || [ "$answer" == "2" ] || [ "$answer" == "3" ] || [ "$answer" == "4" ] || [ "$answer" == "5" ]; then
    echo "Do you want to delete files and folders created in the selected time frame? (Yes/No)"
    read confirm
    if [ "$confirm" == "Yes" ] || [ "$confirm" == "yes" ]; then
      echo "Enter the file path:"
      read varPath

      # Determine which date to use for the search
      case $answer in
        "1")
          cutoff_date=$(date '+%Y-%m-%d')
          ;;
        "2")
          one_month_ago=$(date -d '1 month ago' '+%Y-%m-%d')
          cutoff_date=$one_month_ago
          ;;
        "3")
          two_months_ago=$(date -d '2 months ago' '+%Y-%m-%d')
          cutoff_date=$two_months_ago
          ;;
        "4")
          three_months_ago=$(date -d '3 months ago' '+%Y-%m-%d')
          cutoff_date=$three_months_ago
          ;;
        "5")
          four_months_ago=$(date -d '4 months ago' '+%Y-%m-%d')
          cutoff_date=$four_months_ago
          ;;
      esac

      find "$varPath" -type f -newermt "$cutoff_date" -exec rm {} \;
      find "$varPath" -type d -empty -delete
      echo "Deletion process completed."
    else
      echo "Deletion process canceled."
    fi
  else
    echo "Invalid option. Please try again."
  fi
done
