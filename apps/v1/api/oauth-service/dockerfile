# Set the base image to Python 3.8
FROM python:3.8-slim

# Set environment variables
ENV POETRY_VERSION=1.3.2
ENV PYTHONBUFFERED=1

# Install Poetry and essential packages
RUN apt-get update && apt-get install -y curl && \
  curl -sSL https://install.python-poetry.org | python3 - && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Add Poetry to PATH
ENV PATH /root/.local/bin:$PATH

# Create and set the working directory
WORKDIR /app

# Copy pyproject.toml and poetry.lock first to leverage Docker cache
COPY pyproject.toml poetry.lock* /app/
# Install dependencies
RUN poetry config virtualenvs.create false && \
  poetry install --no-root --no-dev && \
  poetry add uvicorn

# Copy the rest of the application code
COPY . /app/

# Copy files from the public directory and set permissions
# COPY public /app/public
RUN chmod -R 755 /app/public

# Set read and write permissions for clients.json if it exists
# RUN test -f /app/data/clients.json && chmod 666 /app/data/clients.json || echo "clients.json not found yet"
# Set the PYTHONPATH environment variable to include /app
ENV PYTHONPATH /app

# Set the entry command for the Docker container to run the application
CMD ["python", "/app/src/index.py"]
