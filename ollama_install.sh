#!/bin/bash
set -xe

# Create directories
mkdir -p $HOME/.local/bin temp_ollama

# Download Ollama tarball
curl -L -o ollama-linux-amd64.tgz https://ollama.com/download/ollama-linux-amd64.tgz

# List contents of tarball (for debug)
tar -tzf ollama-linux-amd64.tgz

# Extract tarball to temp directory
tar -xzf ollama-linux-amd64.tgz -C temp_ollama

# Find ollama binary inside extracted files
OLLAMA_BIN=$(find temp_ollama -name ollama -type f | head -1)

if [ -z "$OLLAMA_BIN" ]; then
  echo "ERROR: Ollama binary not found after extraction!"
  exit 1
fi

# Move binary to local bin directory
mv "$OLLAMA_BIN" $HOME/.local/bin/ollama

# Clean up
rm -rf temp_ollama ollama-linux-amd64.tgz

# Make binary executable
chmod +x $HOME/.local/bin/ollama

# Verify installation
$HOME/.local/bin/ollama --version

# Start Ollama server in background
$HOME/.local/bin/ollama serve &

# Wait for Ollama API to be ready
until curl -s http://localhost:11434 > /dev/null
do
  echo "Waiting for Ollama API to start..."
  sleep 2
done

# Pull llama3.2 model
$HOME/.local/bin/ollama pull llama3.2:1b

echo "Ollama setup complete."
