#!/bin/bash

# Base URL for raw file access
RAW_BASE_URL="https://raw.githubusercontent.com/LineageOS/android_kernel_oneplus_sm8250/lineage-21"

# List of files and their respective target directories
declare -A FILES_MAP=(
    ["fs/dcache.c"]="fs/"
    ["fs/inode.c"]="fs/"
    ["fs/namei.c"]="fs/"
    ["fs/namespace.c"]="fs/"
    ["fs/open.c"]="fs/"
    ["fs/overlayfs/readdir.c"]="fs/overlayfs/"
    ["fs/proc/task_mmu.c"]="fs/proc/"
    ["fs/proc_namespace.c"]="fs/"
    ["fs/readdir.c"]="fs/"
    ["fs/stat.c"]="fs/"
    ["include/linux/sched/user.h"]="include/linux/sched/"
    ["kernel/sys.c"]="kernel/"
)

# Iterate through the files and replace them in the appropriate subdirectories
for FILE in "${!FILES_MAP[@]}"; do
    TARGET_DIR="${FILES_MAP[$FILE]}"

    # Ensure the target directory exists
    mkdir -p "$TARGET_DIR"

    # Download and replace the file from the repository
    RAW_URL="$RAW_BASE_URL/$FILE"
    echo "Downloading $RAW_URL to $TARGET_DIR"
    curl -fSL "$RAW_URL" -o "$TARGET_DIR/$(basename $FILE)" || {
        echo "Failed to download $FILE. Skipping..."
        continue
    }

done

echo "All files replaced."

