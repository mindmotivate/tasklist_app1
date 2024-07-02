# Use the Chainguard Python latest image for the final stage
FROM cgr.dev/chainguard/python:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the application files from the local host to the container
COPY main.py/ ./

ENTRYPOINT ["python", "/app/main.py"]
# build the docker image using: docker build -t hello-world .
# run the docker image using: docker run --rm hello-world . (after the container is stopped it wil be removed)
# Check your Docker Desktop to see the container running