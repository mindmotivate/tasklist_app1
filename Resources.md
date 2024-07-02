## Resources

### Github Repo:
https://github.com/thecodecity/chainguardpyapp

### Chainguard References:


https://edu.chainguard.dev/chainguard/chainguard-images/overview/
https://edu.chainguard.dev/chainguard/chainguard-images/reference/python/

Chainguard has two Python images available: a python:latest-dev variant that contains pip and a shell, and a minimal runtime image that just contains python itself. (Use this one in your Dockerfile)

These images are available on cgr.dev:

```bash
docker pull cgr.dev/chainguard/python:latest
docker pull cgr.dev/chainguard/python:latest-dev
```



## Setup your Docker configuration:

### Dockerfile Explanation

#### Stage 1: Sets up a build environment

```dockerfile
# Use the Chainguard Python image as the base for the builder stage
FROM cgr.dev/chainguard/python:latest-dev as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file from your app directory to the container
COPY app/requirements.txt .

# Create a virtual environment and install dependencies
RUN python -m venv .venv \               # Create a virtual environment named .venv
    && . .venv/bin/activate \            # Activate the virtual environment
    && pip install --no-cache-dir -r requirements.txt  # Install dependencies from requirements.txt
```

#### Stage 2: Creates a runtime environment

```dockerfile
# Use the Chainguard Python image as the base for the final stage
FROM cgr.dev/chainguard/python:latest

# Set the working directory inside the container
WORKDIR /app

# Copy all contents of the app directory from your host to the container
COPY app/ ./

# Copy the virtual environment (.venv) from the builder stage to the current directory in the container
COPY --from=builder /app/.venv .venv

# Set the entrypoint: This command sets up the primary action for the container when it starts: in other words it says: "hey run.py dammit!"
ENTRYPOINT [".venv/bin/python", "run.py"]
```

## Build & Run Commands: ***Make sure your DockerApp is running!***

```bash
docker build -t sith-task-app .

docker run -it sith-task-app

docker run -p 5000:5000 sith-python-app
```

## Push to Dockerhub: ***Make sure you have a Dockerhub account!***




Tag your local Docker image with the repository name on Docker Hub where you want to push it. This typically follows the format `<username>/<repository>:<tag>`.

```bash
docker tag sith-task-app <username>/sith-task-app:latest

docker login

docker push <username>/sith-task-app:latest
```

```bash
docker pull <username>/sith-task-app:latest
```