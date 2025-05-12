# WARNING: This configuration is for local development only.
# Do not use this configuration in production environments.
# Storage backend configuration
# The "file" storage backend stores Vault data on the local filesystem.

storage "file" {
  path = "./vault-data" # Directory where Vault data will be stored
}

# Listener configuration
# Vault listens for incoming requests on the specified address and port.
# TLS is disabled here for simplicity in local development. Do not disable TLS in production.

listener "tcp" {
  address     = "127.0.0.1:8200" # Bind to localhost only
  tls_disable = 1               # Disable TLS (insecure, for local use only)
}

# Disable memory locking
# This allows Vault to run in environments where mlock is not supported (e.g., macOS).
# Note: Disabling mlock reduces security and should not be used in production.

disable_mlock = true

# Enable the Vault UI
# This allows you to access the Vault web interface at http://127.0.0.1:8200.

ui = true