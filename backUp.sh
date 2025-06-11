#!/bin/bash

echo "$HOME"
sourceDir="$HOME/PRACTICE_PROJECTS"
backupDir="$HOME/backups"
_date=$(date +%Y)

mkdir -p "$backupDir"
cp -r "$sourceDir" "$backupDir/documentsBackup$_date"



