import argparse
import os
import platform
import subprocess

bash = "/bin/bash"
scripts_dir = os.path.join(os.path.dirname(__file__), "scripts")
platform = platform.system().lower()


def check_tool_installation():
    if platform == "windows":
        subprocess.run(
            [
                "powershell",
                "-Command",
                os.path.join(
                    os.path.dirname(__file__), platform, "Check-Tool-Installation.ps1"
                ),
            ]
        )
    else:
        subprocess.run(
            [
                bash,
                os.path.join(
                    os.path.dirname(__file__), platform, "check-tool-installation.sh"
                ),
            ]
        )


def docker_build():
    if platform == "windows":
        subprocess.run(
            [
                "powershell",
                "-Command",
                os.path.join(os.path.dirname(__file__), platform, "Docker-Build.ps1"),
            ]
        )
    else:
        subprocess.run(
            [
                bash,
                os.path.join(os.path.dirname(__file__), platform, "docker-build.sh"),
            ]
        )


def docker_run():
    if platform == "windows":
        subprocess.run(
            [
                "powershell",
                "-Command",
                os.path.join(os.path.dirname(__file__), platform, "Docker-Run.ps1"),
            ]
        )
    else:
        subprocess.run(
            [
                bash,
                os.path.join(os.path.dirname(__file__), platform, "docker-run.sh"),
            ]
        )


def dotenv_pull():
    if platform == "windows":
        subprocess.run(
            [
                "powershell",
                "-Command",
                os.path.join(os.path.dirname(__file__), platform, "Dotenv-Pull.ps1"),
            ]
        )
    else:
        subprocess.run(
            [
                bash,
                os.path.join(os.path.dirname(__file__), platform, "dotenv-pull.sh"),
            ]
        )


def terraform_apply_env():
    if platform == "windows":
        subprocess.run(
            [
                "powershell",
                "-Command",
                os.path.join(
                    os.path.dirname(__file__), platform, "Terraform-Apply-Env.ps1"
                ),
            ]
        )
    else:
        subprocess.run(
            [
                bash,
                os.path.join(
                    os.path.dirname(__file__), platform, "Terraform-Apply-Env.sh"
                ),
            ]
        )


def tf_var_loader():
    if platform == "windows":
        subprocess.run(
            [
                "powershell",
                "-Command",
                os.path.join(os.path.dirname(__file__), platform, "TF_VAR_Loader.ps1"),
            ]
        )
    else:
        subprocess.run(
            [
                bash,
                os.path.join(os.path.dirname(__file__), platform, "TF_VAR_Loader.sh"),
            ]
        )


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
            "check_tool_installation",
            "docker_build",
            "docker_run",
            "dotenv_pull",
            "terraform_apply_env",
            "tf_var_loader",
        ],
        help="The command to execute",
    )

    args = parser.parse_args()
    os.environ["ENV"] = args.env

    if args.command == "check_tool_installation":
        check_tool_installation()
    elif args.command == "docker_build":
        docker_build()
    elif args.command == "docker_run":
        docker_run()
    elif args.command == "dotenv_pull":
        dotenv_pull()
    elif args.command == "terraform_apply_env":
        terraform_apply_env()
    elif args.command == "tf_var_loader":
        tf_var_loader()


if __name__ == "__main__":
    main()
