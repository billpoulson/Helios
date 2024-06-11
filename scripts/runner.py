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
        subprocess.run(["powershell", "-Command", script_path])
    else:
        subprocess.run(["/bin/bash", script_path])
        
def main():
    parser = argparse.ArgumentParser(description="Cross-Platform Script Runner")
    parser.add_argument(
        "env",
        choices=["dev", "stage", "prod"],
        default="dev",
        help="The deployment environment (default: dev)",
    )
    parser.add_argument(
        "command",
        choices=[
            "check-tool-installation",
            "docker-build",
            "docker-run",
            "dotenv-pull",
            "terraform-apply-env",
            "terraform-destroy-env",
            "tf-var-loader",
        ],
        help="The command to execute",
    )

    args = parser.parse_args()
    os.environ["ENV"] = args.env

    run_script(args.command)

if __name__ == "__main__":
    main()
