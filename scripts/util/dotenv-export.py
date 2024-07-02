import subprocess
import os
import json
import fnmatch
import configparser
# import sys
import logging
import argparse

# Set up logging to a file
logging.basicConfig(filename='example.dotenv-export.log',
                    level=logging.INFO, format='%(asctime)s:%(levelname)s:%(message)s')


# Initialize parser
parser = argparse.ArgumentParser()

# Add argument
parser.add_argument("--env", help="Environment variable", default='')
parser.add_argument("--debug", help="enable debug logging", default='false')

# Parse the argument
args = parser.parse_args()

# Get the env variable from argument
env = os.getenv('TF_VAR_env', args.env)
enableDebug = args.debug == 'true'


def run_command(command, cwd=None):
    if enableDebug == True:
        logging.info(f'Running command: {command} in {cwd}')
    process = subprocess.Popen(
        command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, cwd=cwd)
    stdout, stderr = process.communicate()

    stdout_decoded = stdout.decode().strip()
    stderr_decoded = stderr.decode().strip()
    if process.returncode != 0:
        raise Exception(f"Command failed with error: {stderr_decoded}")

    if enableDebug == True:
        logging.info(f'command output: begin=========')
        logging.info(f'{stdout_decoded}')
        logging.info(f'command output: end===========')

    return stdout_decoded


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

    env_command_str = transform_env_value(env, env_map)
    command = f'npx dotenv-vault@latest keys {env_command_str}'

    vault_dirs = find_vault_directories(root_dir, exclude_patterns)
    all_keys = {}

    for directory in vault_dirs:
        helios_path = os.path.join(directory, '.helios')
        project_name = get_project_name(helios_path)

        if not project_name:
            print(f"No project name found in {helios_path}, skipping")
            continue
        try:
            if enableDebug == True:
                logging.info(f'Begin Run: ===========================================')
            parsed_key = run_command(command, cwd=directory)
            if project_name not in all_keys:
                all_keys[project_name] = parsed_key

        except Exception as e:
            print(f"Failed to run command in {directory}: {e}")

    formatted_json = json.dumps(all_keys, indent=2, ensure_ascii=False)

    if enableDebug == True:
        logging.info(f'composite output: begin=========')
        logging.info(f'{formatted_json}')
        logging.info(f'composite output: end===========')
        
    print(formatted_json)


if __name__ == "__main__":
    main()
