#!/bin/bash

# Directory containing node files
node_files_dir="/scratch/faculty/kjann/testenv/outputdir"

# Output file to store the results
output_file="node_numbers_and_filenames.txt"

# Create or clear the output file
> "$output_file"

# Loop through each file in the directory
for file in "$node_files_dir"/node_info*; do
    if [[ -f "$file" ]]; then
        # Extract the filename
        filename=$(basename "$file")
        
        # Extract the NDARINV filename from the filename
        ndar_inv=$(echo "$filename" | grep -oP 'NDARINV\w+' | head -1)

	# Extract the run number from the filename
        run_number=$(echo "$filename" | grep -oP 'run-\K[0-9]+')
        
        # Read the first line of the file to get the node information
        node_info=$(head -n 1 "$file")
        
        # Extract the node number from the node information
        node_number=$(echo "$node_info" | grep -oP 'Linux c\K[0-9]+')
        
        # Write the node number and NDARINV filename to the output file
        echo "Node Number: $node_number, NDARINV Filename: $ndar_inv, Run Number: $run_number" >> "$output_file"
    fi
done

echo "Extraction complete. Results are stored in $output_file."

