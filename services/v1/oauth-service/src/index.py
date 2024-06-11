import os
import json
import logging
import uvicorn

from pathlib import Path
from typing import List
from uuid import uuid4
from jinja2 import Template

from fastapi import FastAPI, HTTPException, Request, Response, status
from fastapi.responses import FileResponse, HTMLResponse, JSONResponse
from models import ClientCreate, ClientView
from oauthlib.oauth2 import Server
from request_validator import RequestValidator
from secret_storage import SecretStorage

BASE_URL = os.getenv("BASE_URL", "")
API_URL = os.getenv("API_URL", "")

# OAuth2 Request Validator.
oauth2 = Server(RequestValidator())
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

print(f"BASE URL: {BASE_URL}")

app = FastAPI(redirect_slashes=False)


# Printing the list of all public files 
public_directory = Path("public")
all_files = [str(file) for file in public_directory.rglob('*') if file.is_file()]
print(all_files)


@app.middleware("http")
async def add_process_time_header(request: Request, call_next):
    # Check if the request path starts with the base URL
    print(f'x1: {request.url.path}')
    if BASE_URL and request.url.path.startswith(BASE_URL):
        # Trim the base_url from the path
        if request.url.path in [BASE_URL, BASE_URL + "/"]:
            new_path = "/index.html"
        else:
            new_path = request.url.path[len(BASE_URL):]
        
        # Update the request scope with the new path
        request.scope["path"] = new_path
        request.scope["raw_path"] = new_path.encode('utf-8')
        
        # Log the URL rewrite
        logger.info(f'{request.url} rewritten to {new_path}')
        print(f"f'{request.url} rewritten to {new_path}'")
    
    # Proceed with the request processing
    response = await call_next(request)
    return response


# Endpoint to register a new OAuth2 client
@app.post("/clients", response_model=ClientView, status_code=status.HTTP_201_CREATED)
async def register_client(client_data: ClientCreate):
    client_id = str(uuid4())
    client_secret = str(uuid4())
    client_info = client_data.dict()
    client_info.update({"client_id": client_id, "client_secret": client_secret})
    SecretStorage.add_client(client_id, client_info)
    return client_info


# Endpoint to get list of all clients
@app.get("/clients", response_model=List[ClientView])
async def get_clients():
    clients = SecretStorage.get_clients()
    return list(clients.values())


# Endpoint to delete a specific client by client_id
@app.delete("/clients/{client_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_client(client_id: str):
    if not SecretStorage.has_client(client_id):
        raise HTTPException(status_code=404, detail="Client not found")
    SecretStorage.remove_client(client_id)
    return Response(status_code=status.HTTP_200_OK)


# Endpoint to generate and return a secure passphrase
@app.get("/generate_passphrase")
async def generate_secure_passphrase_endpoint():
    passphrase = SecretStorage.generate_secure_passphrase()
    return {"passphrase": passphrase}


@app.post("/token")
async def token(request: Request):
    headers, body, status_code = oauth2.create_token_response(
        uri=str(request.url),
        http_method=request.method,
        body=(await request.body()).decode("utf-8"),
        headers=dict(request.headers),
    )

    try:
        body = json.loads(body)
    except json.JSONDecodeError:
        pass

    response = JSONResponse(content=body, status_code=status_code)
    for header, value in headers.items():
        response.headers[header] = value
    return response


@app.get("/{file_path:path}")
async def serve_files(file_path: str = "index.html"):
    print(f"req: {file_path}")
    requested_path = Path("public") / file_path
    if requested_path.exists() and requested_path.is_file():
        if requested_path.suffix in [".html", ".htm"]:
            with open(requested_path, "r", encoding="utf-8") as file:
                template_content = file.read()
            template = Template(template_content)
            rendered_content = template.render(
                base_url=BASE_URL,
                api_url=API_URL
                                               )
            return HTMLResponse(content=rendered_content, status_code=200)
        else:
            return FileResponse(requested_path)

    raise HTTPException(status_code=404, detail=f"{file_path} not found")


if __name__ == "__main__":
    host = os.getenv("HOST", "0.0.0.0")
    port = int(os.getenv("PORT", 8000))
    uvicorn.run(app, host=host, port=port)
