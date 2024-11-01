#!/bin/sh
set -e

SECRET_FILE_PATH="$1"
PATTERN="$2"
ADDITIONAL_ARGS="$3"

# Check if the secret file exists
secret_file_exists() {
  if [ -f "$SECRET_FILE_PATH" ]; then
    echo "Secret already exists at $SECRET_FILE_PATH."
    return 0  # File exists
  else
    echo "No existing secret at $SECRET_FILE_PATH."
    return 1  # File does not exist
  fi
}

export_secrets() {
  # Read the dotenv file and export filtered variables to GITHUB_ENV
  while IFS='=' read -r key value; do
    # Ignore comments and empty lines
    case "$key" in
      \#* | '') continue ;;  # Skip comments and empty lines
    esac

    # Check if the key matches the inclusion pattern
    if echo "$key" | grep -qE "$PATTERN"; then
      # Remove surrounding quotes from value, if any
      value="${value%\"}"
      value="${value#\"}"
      value="${value%\'}"
      value="${value#\'}"
      
      echo "Matched pattern for Key: $key"
      # Mask the value in GitHub Actions to prevent it from being printed
      echo "::add-mask::$value"
      
      # Append each variable to GITHUB_ENV
      echo "$key=$value" >> "$GITHUB_ENV"
    fi
  done < "$SECRET_FILE_PATH"
}

# Decrypt the file using sops and print the contents
decrypt_file() {
  sops -d -i  $ADDITIONAL_ARGS "$SECRET_FILE_PATH"
}

# Main function to handle logic
main() {
  if ! secret_file_exists; then
    echo "The secret file doesn't exist."
    exit 1    
  fi
  echo "Decrypting existing secret file..."
  decrypt_file
  echo "Exporting secrets"
  export_secrets
}

main
