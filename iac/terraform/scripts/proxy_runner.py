# proxy_runner.py
import os
import subprocess
import sys

def main():
    # Change this to the desired working directory
    desired_working_directory = "/path/to/desired/directory"
    
    # Change to the desired working directory
    os.chdir(desired_working_directory)
    
    # Pass all arguments from this script to the real script
    script_args = ["python3", "./scripts/runner.py"] + sys.argv[1:]
    
    # Execute the real script with the modified working directory
    result = subprocess.run(script_args, check=True)
    
    # Exit with the real script's exit code
    sys.exit(result.returncode)

if __name__ == "__main__":
    main()
