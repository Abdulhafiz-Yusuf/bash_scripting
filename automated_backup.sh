#!/bin/bash

# 🎯 Goal: Create and manage backups of project files.
# Step-by-step Features:
# 	1. Define a source directory to back up.
# 	2. Check if source directory exists.
# 	3. Create a backup name like backup_YYYY-MM-DD.tar.gz.
# 	4. Compress the directory with tar and gzip.
# 	5. Ensure /backups directory exists or create it.
# 	6. Move the backup there.
# 	7. Delete backups older than 7 days (use find with -mtime).
# 	8. Optional: Add logging for success/failure.



#SOLUTION
# Step-by-step Features:
# 	1. Define a source directory to back up.
SOURCE_FILE="./backUp.sh"

# 	2. Check if source directory exists.
if [ ! -e $SOURCE_FILE ]; then
    echo "ERROR: $SOURCE_FILE not found"
    exit 1
fi

# 	3. Create a backup name like backup_YYYY-MM-DD.tar.gz.
BACKUP_NAME="backup_$(date +%F).tar.gz"
# 	4. Compress the directory with tar and gzip.
tar -czf $BACKUP_NAME $SOURCE_FILE
# 	5. Ensure /backups directory exists or create it.
BACKUP_DESTINATION="./backups"
if [ ! -d $BACKUP_DESTINATION ]; then
mkdir $BACKUP_DESTINATION
fi
# 	6. Move the backup there.
mv "$BACKUP_NAME" "$BACKUP_DESTINATION/"
# 	7. Delete backups older than 7 days (use find with -mtime).
find "$BACKUP_DESTINATION" -name "backup_*.tar.gz" -type f -mtime +7 -exec rm f {} \;

# 	8. Optional: Add logging for success/failure.
echo "[INFO] Backup of '$SOURCE_FILE' completed successfully as '$BACKUP_DIR/$BACKUP_NAME'"