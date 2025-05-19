#!/bin/bash

# Directory containing subject files
subj_files_dir="/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/OCD_ABCD_PreprocComplexWOdenoise"

# Output file to store the results
output_file="subjnames.txt"

# Create or clear the output file
> "$output_file"

# Create a temporary file to track unique identifiers
temp_file=$(mktemp)

# Loop through each file in the directory
for file in "$subj_files_dir"/*; do
    if [[ -f "$file" ]]; then
        # Extract the filename
        filename=$(basename "$file")
        
        # Extract the NDARINV part from the filename and trim any extra whitespace
        ndar_inv=$(echo "$filename" | grep -oP 'swusub-NDARINV\w+' | awk '{$1=$1;print}')

        # Add the NDARINV identifier to the temporary file if it's not already present
        if ! grep -q "^$ndar_inv\$" "$temp_file"; then
            echo "$ndar_inv" >> "$temp_file"
        fi
    fi
done

# Sort the temporary file, remove duplicates, and write to the output file
sort -u "$temp_file" > "$output_file"

# Remove the temporary file
rm "$temp_file"

echo "Extraction complete. Results are stored in $output_file."




