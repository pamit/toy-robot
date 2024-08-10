#!/bin/bash

# If a command fails or returns exit > 0, then the shell immediately exits.
set -e

# Place for running health checks or other commands before running the app
# e.g. calling a health check endpoint on the server
echo "Running health checks before starting the app..."

# Execute the container's main process (CMD in the Dockerfile)
exec "$@"
