#!/bin/bash

#List of scripts to execute

scripts=(
        "sim_run_9.1/lud-rodinia-3.1/_s_256__v/QV100-PTX-1B_INSN/justrun.sh"
        "sim_run_9.1/lud-rodinia-3.1/_s_256__v/QV100-SASS-1B_INSN/justrun.sh"
        "sim_run_9.1/gaussian-rodinia-3.1/_f___data_matrix208_txt/QV100-PTX-1B_INSN/justrun.sh"
        "sim_run_9.1/gaussian-rodinia-3.1/_f___data_matrix208_txt/QV100-SASS-1B_INSN/justrun.sh"
)

# Loop through each script
for script_path in "${scripts[@]}"; do
    # Extract directory and filename
    script_dir=$(dirname "$script_path")
    script_name=$(basename "$script_path")

    echo "Running $script_name in $script_dir..."

    # Change to the script's directory
    cd "$script_dir" || { echo "Failed to cd into $script_dir"; exit 1; }

    # Run the script from within its directory
    bash "./$script_name"

    # Check result
    if [ $? -eq 0 ]; then
        echo "$script_name completed successfully."
    else
        echo "$script_name failed with error code $?."
        # Optional: exit on failure
        # exit 1
    fi

    echo "---------------------------"
done

echo "All scripts executed."

