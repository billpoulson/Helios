document.addEventListener('DOMContentLoaded', (event) => {
  const clientForm = document.getElementById('client-form');
  const clientList = document.getElementById('clients');
  const generatePassphraseBtn = document.getElementById('generate-passphrase');
  const passphraseDisplay = document.getElementById('passphrase');

  clientForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const formData = new FormData(clientForm);
    const data = {
      name: formData.get('name'),
      redirect_uris: formData.get('redirect_uris').split(',').map(uri => uri.trim()).filter(uri => uri),
      default_scopes: formData.get('default_scopes').split(',').map(uri => uri.trim()).filter(uri => uri),
      allowed_scopes: formData.get('allowed_scopes').split(',').map(uri => uri.trim()).filter(uri => uri),
    };

    try {
      const response = await fetch('/clients', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
      });
      if (response.ok) {
        const newClient = await response.json();
        addClientToList(newClient);
        clientForm.reset();
      } else {
        const errorData = await response.json();
        alert(`Error: ${errorData.detail}`);
      }
    } catch (error) {
      alert('An error occurred while registering the client.');
    }
  });

  generatePassphraseBtn.addEventListener('click', async () => {
    try {
      const response = await fetch('/generate_passphrase', {
        method: 'GET'
      });
      if (response.ok) {
        const data = await response.json();
        displayPassphrase(data);
      } else {
        alert('Failed to generate passphrase.');
      }
    } catch (error) {
      alert('An error occurred while generating passphrase.');
    }
  });

  async function fetchClients() {
    try {
      const response = await fetch('/clients');
      if (response.ok) {
        const clients = await response.json();
        clientList.innerHTML = ''; // Clear the existing list
        clients.forEach(addClientToList);
      } else {
        console.error('Failed to fetch clients');
      }
    } catch (error) {
      console.error('An error occurred while fetching clients', error);
    }
  }

  function addClientToList(client) {
    const deleteButtonHtml = `<button class="btn btn-danger btn-sm mt-2" onclick="deleteClient('${client.client_id}', this)">Delete</button>`;
    const clientItem = document.createElement('div');
    clientItem.className = 'client-item';
    clientItem.innerHTML = `
          <strong>${client.name}</strong><br>
          Client ID: ${client.client_id}<br>
          Client Secret: ${client.client_secret}<br>
          Redirect URIs: ${client.redirect_uris.join(', ')}<br>
          Default Scopes: ${client.default_scopes.join(', ')}<br>
          Allowed Scopes: ${client.allowed_scopes.join(', ')}
          ${deleteButtonHtml}
      `;
    clientList.appendChild(clientItem);
  }


  function displayPassphrase(data) {
    passphraseDisplay.innerHTML = `
          <div class="passphrase-item">
              Generated Passphrase: <strong>${data.passphrase}</strong>
          </div>
      `;
  }

  setInterval(fetchClients, 5000); // Reload the client list every 5 seconds
  fetchClients();
});


async function deleteClient(clientId, button) {
  try {
    const response = await fetch(`/clients/${clientId}`, {
      method: 'DELETE'
    });
    if (response.ok) {
      const clientItem = button.parentElement;
      clientItem.remove();
    } else {
      alert('Failed to delete client.');
    }
  } catch (error) {
    alert('An error occurred while deleting the client.');
  }
}
