# Stage 1: Builder
FROM python:3.12 AS builder

WORKDIR /app

# Copy requirements.txt from current directory
COPY requirements.txt .

# Copy all files and directories from current directory (including app code)
RUN python -m venv .venv \
  && . .venv/bin/activate \
  && pip install --no-cache-dir -r requirements.txt

# Stage 2: Final Image
FROM python:3.12

WORKDIR /app

COPY . .

COPY --from=builder /app/.venv .venv  # Copy virtual environment from builder stage

ENTRYPOINT [".venv/bin/python", "run.py"]
