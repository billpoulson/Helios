import argparse
import os
import platform as pf
import subprocess

def run_script(script_name):
    platform = pf.system().lower()
    script_dir = os.path.join(os.path.dirname(__file__), platform)
    script_ext = ".ps1" if platform == "windows" else ".sh"
    script_path = os.path.join(script_dir, script_name + script_ext)

    if platform == "windows":
        subprocess.run(["powershell", "-Command", script_path], check=True)
    else:
        subprocess.run(["/bin/bash", script_path], check=True)
        
def main():
    parser = argparse.ArgumentParser(description="Cross-Platform Script Runner")
    parser.add_argument(
        "-e", "--env",
        choices=["dev", "stage", "prod"],
        default="dev",
        help="The deployment environment (default: dev)",
    )
    parser.add_argument(
        "-c","--commands",
        nargs='+',  # This allows for one or more command inputs
        choices=[
            "check-tool-installation",
            "docker-build",
            "docker-run",
            "dotenv-pull",
            "terraform-burn",
            "bootstrap-cluster",
            "terraform-init-env",
            "terraform-plan-env",
            "terraform-apply-env",
            "terraform-destroy-env",
            "tf-var-loader",
        ],
        required=True,  # Makes sure that at least one command is provided
        help="The command(s) to execute",
    )
  
    args = parser.parse_args()
    os.environ["ENV"] = args.env
    for command in args.commands:
        try:
            run_script(command)
        except subprocess.CalledProcessError as e:
            print(f"Error running script {command}: {e}")
            break

if __name__ == "__main__":
    main()
