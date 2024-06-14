import os
import sys

def process_env_file(env_path):
    try:
        with open(env_path, 'r') as file:
            lines = file.readlines()
    except FileNotFoundError:
        print(f"Error: File {env_path} not found.")
        return
    
    total_lines = len(lines)
    current_line = 0

    for line in lines:
        line = line.strip()
        if '=' in line and not line.startswith('#'):
            key, value = line.split('=', 1)
            if len(value) > 6:
                obscured_value = f"{value[:3]}{'*' * (len(value) - 6)}{value[-3:]}"
            else:
                obscured_value = value

            os.environ[f"TF_VAR_{key}"] = value
            current_line += 1
            percentage = (current_line / total_lines) * 100
            print(f"  converted key {key} >>> TF_VAR_{key} with value: {obscured_value}")
        
        elif line.startswith('#'):
            print(f"  skipped line: {line}")
        
    print()

def main():
    if len(sys.argv) > 1:
        environment = sys.argv[1]
    else:
        environment = ""
    default_envs = ["", "dev", "local", "development"]

    if environment in default_envs:
        file_path = ".env"
    else:
        file_path = f".env.{environment}"

    process_env_file(file_path)

if __name__ == "__main__":
    main()
