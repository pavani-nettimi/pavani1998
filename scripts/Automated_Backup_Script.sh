#!/bin/bash

# Usage: <SOURCE_DIR> <BACKUP_DEST>

SOURCE_DIR=$1
BACKUP_DEST=$2
LOG_FILE=Backup_File

if [ -z "$SOURCE_DIR" ] || [ -z "$BACKUP_DEST" ]; then
  echo "Usage: $0 <SOURCE_DIR> <BACKUP_DEST>"
  exit 1
fi

TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DEST"
tar -czf "$BACKUP_DEST/$BACKUP_NAME" -C "$SOURCE_DIR" .

if [ $? -eq 0 ]; then
  echo "$(date): Backup successful: $BACKUP_NAME" >> "$LOG_FILE"
  echo "Backup successful."
else
  echo "$(date): Backup FAILED!" >> "$LOG_FILE"
  echo "Backup failed!"
fi
