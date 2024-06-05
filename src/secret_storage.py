import json
import os
import secrets
import string
import threading
from pathlib import Path
from typing import Dict


class SecretStorage:
    _clients_file = Path(os.getenv("CLIENTS_JSON_PATH", "./data/clients.json"))
    _lock = threading.Lock()

    @staticmethod
    def save_token(token_data):
        # Implementation to save token_data in your storage (e.g., database)
        pass

    @classmethod
    def has_client(cls, client_id: str) -> bool:
        clients = cls._load_clients()
        return client_id in clients

    @classmethod
    def _load_clients(cls) -> Dict[str, dict]:
        with cls._lock:
            if cls._clients_file.exists():
                try:
                    with cls._clients_file.open("r") as file:
                        a = json.load(file)
                        return a
                except json.JSONDecodeError as e:
                    raise RuntimeError(f"Failed to parse JSON data: {e}")
            return {}

    @classmethod
    def _save_clients(cls, clients: Dict[str, dict]):
        with cls._lock:
            with cls._clients_file.open("w") as file:
                json.dump(clients, file, indent=4)

    @classmethod
    def get_clients(cls) -> Dict[str, dict]:
        return cls._load_clients()

    @classmethod
    def remove_client(cls, client_id: str):
        clients = cls._load_clients()
        if client_id in clients:
            del clients[client_id]
            cls._save_clients(clients)

    @classmethod
    def add_client(cls, client_id: str, data: dict):
        clients = cls._load_clients()
        clients[client_id] = data
        cls._save_clients(clients)

    @classmethod
    def get_client(cls, client_id: str) -> dict:
        clients = cls._load_clients()
        return clients.get(client_id)

    @classmethod
    def delete_client(cls, client_id: str):
        clients = cls._load_clients()
        if client_id in clients:
            del clients[client_id]
            cls._save_clients(clients)

    @classmethod
    def generate_secure_passphrase(cls, length=20):
        characters = string.ascii_letters + string.digits + string.punctuation
        passphrase = "".join(secrets.choice(characters) for i in range(length))
        return passphrase
