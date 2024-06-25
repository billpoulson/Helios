import os
import subprocess
import json

def install_dependencies():
    kubecontext = os.environ.get("HELIOS_KUBE_CONTEXT", "default")
    try:
        # Add Jetstack Helm repo
        subprocess.run(['helm', 'repo', 'add', 'jetstack', 'https://charts.jetstack.io'], check=True)
        # Update Helm repos
        subprocess.run(['helm', 'repo', 'update'], check=True)  
        # Use specific kubernetes context
        subprocess.run(['kubectl', 'config', 'use-context', kubecontext], check=True)
        
        # Install Cert Manager
        subprocess.run(['helm', 'upgrade', '--install', 'cert-manager', '--repo', 'https://charts.jetstack.io', 'cert-manager', '--namespace', 'cert-manager', 
        '--create-namespace', '--version', 'v1.12.0', 
                        '--set', 'installCRDs=true'
                        ], check=True)
    
    except subprocess.CalledProcessError as e:
        # Log error message
        print(f'ERROR: {e}')

        # Return unsuccessful JSON
        return json.dumps({ 'completed': False }, indent=2, ensure_ascii=False)
    

install_dependencies()
jsonOutput= json.dumps({ 'completed': True })

print(jsonOutput)
