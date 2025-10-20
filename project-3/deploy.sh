#!/bin/bash

source .env

SSH_KEY=$SSH_KEY
USER=$USER
HOST=$HOST
REMOTE_DIR="/var/www/html"
LOCAL_DIR="./website"

# Exit on error
set -e

chmod 600 "$SSH_KEY" 2>/dev/null || true

echo "Setting up remote directory..."
ssh -i "$SSH_KEY" "$USER@$HOST" "sudo mkdir -p $REMOTE_DIR && \
    sudo chown -R $USER:$USER $REMOTE_DIR && \
    sudo chmod -R 755 $REMOTE_DIR"

echo "Syncing remote directory with local files..."
rsync -avz --delete -e "ssh -i $SSH_KEY" "$LOCAL_DIR/" "$USER@$HOST:$REMOTE_DIR/"

if [ $? -eq 0 ]; then
    echo "✓ Deployment complete."
    echo "Your site is live at: http://$HOST"
else
    echo "✗ Deployment failed!"
    exit 1
fi
