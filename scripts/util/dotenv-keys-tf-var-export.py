import os
import json

def load_projects_env(file_path):
    full_path = os.path.abspath(file_path)
    print(f"Full path to the keys.json file: {full_path}")
    try:
        with open(full_path, 'r') as file:
            projects_env = json.load(file)
        return projects_env
    except FileNotFoundError:
        print(f"File '{full_path}' not found.")
        return None
    except json.JSONDecodeError:
        print(f"File '{full_path}' is not a valid JSON.")
        return None

def set_env_variables_for_project(projects_env, project, environment):
    project = project.upper() 
    if project in projects_env:
        if environment in projects_env[project]:
            key_value = projects_env[project][environment]
            env_key = f"TF_VAR_{project}_DOTENV_KEY"
            os.environ[env_key] = key_value
            print(f"Set {env_key} with value: {key_value}")
        else:
            print(f"Environment '{environment}' not found for project '{project}'")
    else:
        print(f"Project '{project}' not found")

def main():
    environment = os.getenv("env", "development")  # Default to "development" if "env" is not set
    file_path = "dotenv.keys.json"  # Path to the JSON file

    projects_env = load_projects_env(file_path)
    if projects_env is None:
        return  # Exit if we couldn't load the projects_env
    for project in projects_env.keys():
        set_env_variables_for_project(projects_env, project, environment)
        

if __name__ == "__main__":
    main()
