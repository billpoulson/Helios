from oauthlib.oauth2 import Client
from oauthlib.oauth2 import RequestValidator as OAuth2RequestValidator
from secret_storage import SecretStorage


class RequestValidator(OAuth2RequestValidator):
    def validate_client_id(self, client_id, request, *args, **kwargs):
        client = SecretStorage.get_client(client_id)
        if client:
            request.client = Client(client_id=client_id)
            return True
        return False

    def validate_client_secret(
        self, client_id, client_secret, request, *args, **kwargs
    ):
        client = SecretStorage.get_client(client_id)
        if client and client["client_secret"] == client_secret:
            return True
        return False

    def validate_grant_type(
        self, client_id, grant_type, client, request, *args, **kwargs
    ):
        client_id = request.client_id
        client = SecretStorage.get_client(client_id)
        if client:
            allowed_grant_types = client.get("allowed_grant_types", [])

            # If no grant types are specified, allow all grant types
            if len(allowed_grant_types) == 0:
                return True

            if request.grant_type in allowed_grant_types:
                return True
        return False

    def get_default_scopes(self, client_id, request, *args, **kwargs):
        client = SecretStorage.get_client(client_id)
        if client:
            # Retrieve default scopes from client information
            default_scopes = client.get("default_scopes", [])
            return default_scopes
        # If no default scopes are found, return an empty list or sensible default
        return []

    def validate_scopes(self, client_id, scopes, client, request, *args, **kwargs):
        client = SecretStorage.get_client(client_id)
        if not client:
            return False

        allowed_scopes = set(client.get("allowed_scopes", []))
        requested_scopes = set(scopes)

        # Check if all requested scopes are in the set of allowed scopes
        if requested_scopes.issubset(allowed_scopes):
            return True
        return False

    # raise NotImplementedError('Subclasses must implement this method.')
    # NotImplementedError: Subclasses must implement this method.
    def authenticate_client(self, request, *args, **kwargs):
        return self.validate_client_id(request.client_id, request)

    def save_bearer_token(self, token, request, *args, **kwargs):
        # Extract necessary details from the token and request
        client_id = request.client.client_id
        user_id = request.user.username if request.user else None
        scopes = token.get("scope")
        access_token = token.get("access_token")
        refresh_token = token.get("refresh_token")
        expires_in = token.get("expires_in")

        # Prepare the token data
        token_data = {
            "client_id": client_id,
            "user_id": user_id,
            "scopes": scopes,
            "access_token": access_token,
            "refresh_token": refresh_token,
            "expires_in": expires_in,
        }

        # Save the token data to the SecretStorage
        SecretStorage.save_token(token_data)
