#!/bin/sh
set -e

SECRET_NAME="$1"
SECRET_VALUE="$2"
SECRET_FILE_PATH="$3"
ADDITIONAL_ARGS="$4"

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

# Encrypt the file using sops and store it in SECRET_FILE_PATH
encrypt_file() {
  sops -e -i $ADDITIONAL_ARGS "$SECRET_FILE_PATH"
}

# Decrypt the file using sops and print the contents
decrypt_file() {
  sops -d -i  $ADDITIONAL_ARGS "$SECRET_FILE_PATH"
}

upsert_secret() {
  if grep -q "^${SECRET_NAME}=" "$SECRET_FILE_PATH"; then
    # If it exists, replace it with the new value
    sed -i "s/^${SECRET_NAME}=.*/${SECRET_NAME}=${SECRET_VALUE}/" "$SECRET_FILE_PATH"
  else
    # If it doesn't exist, append it to the end of the file
    echo "${SECRET_NAME}=${SECRET_VALUE}" >> "$SECRET_FILE_PATH"
  fi
}

# Main function to handle logic
main() {
  if secret_file_exists; then
    echo "Decrypting existing secret file..."
    decrypt_file
  else
    echo "The secret file doesn't exist. Creating a new one ..."
    touch "$SECRET_FILE_PATH"
  fi
  echo "Upserting the secret $SECRET_NAME"
  upsert_secret
  echo "Encrypting the secret file $SECRET_FILE_PATH"
  encrypt_file
}

main
