import os
import csv
import re

# List to store our results
results = []

# Get all files in current directory ending with .o followed by numbers
current_dir = os.getcwd()
for filename in os.listdir(current_dir):
    if re.match(r'.*\.o\d+$', filename):  # Matches files ending in .o followed by numbers
        last_cache_miss = None
        
        # Read each file
        with open(filename, 'r') as f:
            # Look at each line
            for line in f:
                # Search for L2_total_cache_misses pattern
                match = re.search(r'L2_total_cache_misses = (\d+)', line)
                if match:
                    last_cache_miss = match.group(1)  # Update with the latest value found
        
        # If we found at least one match in the file, add to results
        if last_cache_miss is not None:
            results.append([filename, last_cache_miss])

# Write results to CSV
with open('cache_misses_output.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    # Write header
    writer.writerow(['Filename', 'L2_total_cache_misses'])
    # Write all results
    writer.writerows(results)

print(f"Processed {len(results)} files. Results written to cache_misses_output.csv")