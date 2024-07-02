# Stage 1: Builder
FROM cgr.dev/chainguard/python:latest-dev as builder

WORKDIR /app

COPY app/requirements.txt .

RUN python -m venv .venv \
    && . .venv/bin/activate \
    && pip install --no-cache-dir -r requirements.txt

# Stage 2
FROM cgr.dev/chainguard/python:latest

WORKDIR /app

COPY app/ ./

COPY --from=builder /app/.venv .venv

ENTRYPOINT [".venv/bin/python", "run.py"]