#!/bin/bash

# Usage: ./find_duplicates.sh /path/to/directory

# Check if the directory is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

# Assign input directory to a variable
DIR=$1

# Print directory for debugging
echo "Using directory: $DIR"

# Temporary files for storing checksums and results
UNSORTED_HASHES=$(mktemp /tmp/unsorted_hashes.XXXXXX)
SORTED_HASHES=$(mktemp /tmp/sorted_hashes.XXXXXX)
DUPLICATE_HASHES=$(mktemp /tmp/duplicate_hashes.XXXXXX)
DUPLICATE_FILES=$(mktemp /tmp/duplicate_files.XXXXXX)

# Step 1: Generate checksums for all relevant files in the directory
echo "Generating checksums for files in $DIR..."
find "$DIR" -type f -name "swusub-NDARINV*.nii" -exec shasum {} \; > "$UNSORTED_HASHES"

# Check how many files were found
num_files=$(wc -l < "$UNSORTED_HASHES")
echo "Number of files processed: $num_files"

if [ $num_files -eq 0 ]; then
    echo "No files found with the pattern swusub-NDARINV*.nii"
    exit 1
fi

# Step 2: Sort the checksums
echo "Sorting checksums..."
sort "$UNSORTED_HASHES" > "$SORTED_HASHES"

# Step 3: Find duplicate checksums (those that appear more than once)
echo "Finding duplicate checksums..."
awk '{print $1}' "$SORTED_HASHES" | sort | uniq -d > "$DUPLICATE_HASHES"

# Step 4: List the duplicate files corresponding to the duplicate checksums
echo "Listing duplicate files..."
grep -Ff "$DUPLICATE_HASHES" "$SORTED_HASHES" > "$DUPLICATE_FILES"

# Step 5: Display results
echo ""
echo "Duplicate files in $DIR:"
cat "$DUPLICATE_FILES"

# Optional: Save the results to a file
echo "Saving results to MSE_duplicate_files.txt..."
cat "$DUPLICATE_FILES" > MSE_duplicate_files.txt

# Clean up temporary files
rm "$UNSORTED_HASHES" "$SORTED_HASHES" "$DUPLICATE_HASHES" "$DUPLICATE_FILES"

echo "Done!"

