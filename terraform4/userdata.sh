#!/bin/bash
set -euxo pipefail

# Install Docker Engine + Compose plugin (same approach as terraform3)
curl -fsSL https://get.docker.com | sh
systemctl enable --now docker

# Allow SSM user to run docker without sudo
id ssm-user &>/dev/null || useradd -m ssm-user
usermod -aG docker ssm-user

# Deploy Rackula via the official self-hosting compose command
mkdir -p /opt/rackula
cd /opt/rackula
curl -fsSL https://raw.githubusercontent.com/RackulaLives/Rackula/main/deploy/docker-compose.persist.yml -o docker-compose.yml
mkdir -p data
chown 1001:1001 data
docker compose up -d
