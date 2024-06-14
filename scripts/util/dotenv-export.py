import subprocess
import os
import json
import fnmatch
import configparser
import sys
def run_command(command, cwd=None):
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, cwd=cwd)
    stdout, stderr = process.communicate()
    
    stdout_decoded = stdout.decode().strip()
    stderr_decoded = stderr.decode().strip()
    if process.returncode != 0:
        raise Exception(f"Command failed with error: {stderr_decoded}")
    return stdout_decoded
def parse_output(output):
    lines = output.split('\n')
    keys = {}

    for line in lines:
        if line.strip() != '' and 'dotenv://' in line:
            parts = line.strip().split()
            if len(parts) == 2:
                environment, key = parts
                keys[environment] = key

    return keys

def find_vault_directories(root_dir, exclude_patterns):
    vault_dirs = []
    for dirpath, _, filenames in os.walk(root_dir):
        if any(fnmatch.fnmatch(dirpath, pattern) for pattern in exclude_patterns):
            continue
        if '.helios' in filenames:
            vault_dirs.append(dirpath)
    return vault_dirs

def load_config():
    script_dir = os.path.dirname(os.path.realpath(__file__))
    script_name = os.path.splitext(os.path.basename(__file__))[0]
    config_file = os.path.join(script_dir, f"{script_name}.config.json")
    with open(config_file) as f:
        config = json.load(f)
    return config

def transform_env_value(env_val, env_map):
    return env_map.get(env_val, env_val)

def get_project_name(helios_path):
    config = configparser.ConfigParser()
    config.read(helios_path)
    return config['dotenv']['project'] if 'dotenv' in config and 'project' in config['dotenv'] else None
def main():
    config = load_config()
    env_map = config.get('env_map', {})
    exclude_patterns = config.get('exclude_patterns', [])

    root_dir = '.'
    
    # Check if the file exists
    if os.path.exists('./dotenv.keys.json'):
        print(json.dumps({}))
        sys.exit()
        
    # env = os.getenv('env', 'dev')
    # env_command_str = transform_env_value(env, env_map)
    command = f'npx dotenv-vault@latest keys'
    
    vault_dirs = find_vault_directories(root_dir, exclude_patterns)
    all_keys = {}
    
    for directory in vault_dirs:
        helios_path = os.path.join(directory, '.helios')
        project_name = get_project_name(helios_path)

        if not project_name:
            print(f"No project name found in {helios_path}, skipping")
            continue
        try:
            output = run_command(command, cwd=directory)
            parsed_keys = parse_output(output)
            if project_name not in all_keys:
                all_keys[project_name] = {}
            all_keys[project_name].update(parsed_keys)
        except Exception as e:
            print(f"Failed to run command in {directory}: {e}")

    formatted_json = json.dumps(all_keys, indent=2, ensure_ascii=False)
    
    # Save formatted_json to dotenv.keys.json
    with open('./dotenv.keys.json', 'w') as json_file:
        json_file.write(formatted_json)
        
        
    print(json.dumps({}))
if __name__ == "__main__":
    main()
