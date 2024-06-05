# Pydantic Client Models
from typing import List

from pydantic import BaseModel, Field


class ClientCreate(BaseModel):
    name: str
    redirect_uris: List[str] = Field(default_factory=list)
    default_scopes: List[str] = Field(default_factory=list)
    allowed_scopes: List[str] = Field(default_factory=list)


class ClientView(ClientCreate):
    client_id: str
    client_secret: str
    default_scopes: List[str]
    allowed_scopes: List[str]
