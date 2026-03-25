#!/usr/bin/env bash
set -euo pipefail

echo "=== Updating system packages ==="
sudo apt-get update
sudo apt-get upgrade -y

echo "=== Installing Docker ==="
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker "$USER"

echo "=== Installing Nginx ==="
sudo apt-get install -y nginx

echo "=== Installing Certbot ==="
sudo apt-get install -y snapd
sudo snap install core && sudo snap refresh core
sudo snap install --classic certbot
sudo ln -sf /snap/bin/certbot /usr/bin/certbot

echo "=== Configuring Nginx ==="
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo cp "$SCRIPT_DIR/nginx/kritsada.me.conf" /etc/nginx/sites-available/kritsada.me
sudo ln -sf /etc/nginx/sites-available/kritsada.me /etc/nginx/sites-enabled/kritsada.me
sudo rm -f /etc/nginx/sites-enabled/default

sudo nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx

echo "=== Enabling Docker service ==="
sudo systemctl enable docker

echo ""
echo "============================================"
echo "  Setup complete!"
echo "  Next steps:"
echo "    1. Log out and back in (for docker group)"
echo "    2. Run: ./deploy/deploy.sh"
echo "    3. Run: sudo certbot --nginx -d kritsada.me -d www.kritsada.me"
echo "============================================"
