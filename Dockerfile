# Stage 1: Builder
FROM python:3.12 AS builder

WORKDIR /app

# Copy requirements.txt from current directory
COPY requirements.txt .

# Create virtual environment and install dependencies
RUN python -m venv .venv \
    && . .venv/bin/activate \
    && pip install --no-cache-dir -r requirements.txt

# Stage 2: Final Image
FROM python:3.12

WORKDIR /app

# Copy all files and directories from current directory (including app code)
COPY . .

# Copy virtual environment from builder stage
COPY --from=builder /app/.venv .venv/

# Set the entrypoint to run the application
ENTRYPOINT [".venv/bin/python", "run.py"]
