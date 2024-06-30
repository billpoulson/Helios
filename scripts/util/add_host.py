import os
import sys
import platform
import subprocess
import ctypes

def is_root():
    if platform.system() == "Windows":
        try:
            # Check for admin rights
            return ctypes.windll.shell32.IsUserAnAdmin()
        except:
            return False
    else:
        return os.geteuid() == 0

def get_hosts_file():
    if platform.system() == "Windows":
        return r"C:\Windows\System32\drivers\etc\hosts"
    else:
        return "/etc/hosts"

def backup_hosts_file(hosts_file):
    backup_file = f"{hosts_file}.bak"
    with open(hosts_file, 'r') as f:
        with open(backup_file, 'w') as bf:
            bf.write(f.read())
    print(f"Backup of {hosts_file} created at {backup_file}")

def add_host_entry(hostname, ip_address, hosts_file):
    with open(hosts_file, 'r+') as file:
        lines = file.readlines()
        for i, line in enumerate(lines):
            if hostname in line:
                lines[i] = f"{ip_address}\t{hostname}\n"
                break
        else:
            lines.append(f"{ip_address}\t{hostname}\n")
        file.seek(0)
        file.writelines(lines)
    print(f"Hostname {hostname} with IP address {ip_address} added to {hosts_file}")

def flush_dns_cache():
    if platform.system() == "Windows":
        subprocess.run(["ipconfig", "/flushdns"], check=True)
    elif platform.system() == "Darwin":
        subprocess.run(["dscacheutil", "-flushcache"], check=True)
        subprocess.run(["killall", "-HUP", "mDNSResponder"], check=True)
    elif platform.system() == "Linux":
        subprocess.run(["systemctl", "restart", "networking"], check=True)
    print("DNS cache flushed.")

def main():
    if not is_root():
        print("This script must be run as root. Use sudo or run as Administrator.")
        sys.exit(1)

    if len(sys.argv) != 3:
        print("Usage: sudo python3 add_host.py <hostname> <ip_address>")
        sys.exit(1)

    hostname = sys.argv[1]
    ip_address = sys.argv[2]
    hosts_file = get_hosts_file()

    backup_hosts_file(hosts_file)
    add_host_entry(hostname, ip_address, hosts_file)
    flush_dns_cache()
    print(f"Done. {hostname} has been added to {hosts_file} with IP address {ip_address}.")

if __name__ == "__main__":
    main()
