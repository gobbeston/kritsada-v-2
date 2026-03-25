#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR"

echo "=== Pulling latest code ==="
git pull origin main

echo "=== Building Docker image ==="
docker compose build

echo "=== Starting container ==="
docker compose up -d

echo "=== Waiting for health check ==="
sleep 3

if curl -sf http://127.0.0.1:3000 > /dev/null 2>&1; then
  echo "  Container is healthy!"
else
  echo "  WARNING: Container may not be ready yet. Check logs:"
  echo "    docker compose logs -f"
fi

echo ""
echo "=== Deployment complete ==="
echo "  Running containers:"
docker compose ps
