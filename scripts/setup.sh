#!/bin/bash
set -e

# Load environment variables
if [ ! -f vault/secrets.env ]; then
  echo "Error: vault/secrets.env file not found. Please create it before running this script."
  exit 1
fi
source vault/secrets.env

# Validate required environment variables
if [ -z "$VAULT_ROOT_TOKEN" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
  echo "Error: One or more required environment variables (VAULT_ROOT_TOKEN, DB_USER, DB_PASSWORD) are not set."
  exit 1
fi

# Log in to Vault
vault login "$VAULT_ROOT_TOKEN" || { echo "Error: Failed to log in to Vault."; exit 1; }

# Enable KV secrets engine
vault secrets enable -path=secrets kv || true

# Store the credentials
vault kv put secrets/db-creds username="$DB_USER" password="$DB_PASSWORD" || { echo "Error: Failed to store secrets."; exit 1; }

echo "Secrets have been successfully stored in Vault."