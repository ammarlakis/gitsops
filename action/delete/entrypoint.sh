#!/bin/sh
set -e

SECRET_NAME="$1"
SECRET_FILE_PATH="$2"
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

# Encrypt the file using sops and store it in SECRET_FILE_PATH
encrypt_file() {
  sops -e -i $ADDITIONAL_ARGS "$SECRET_FILE_PATH"
}

# Decrypt the file using sops and print the contents
decrypt_file() {
  export SOPS_KMS_ARN=$(grep '^sops_kms__list_0__map_arn=' "$SECRET_FILE_PATH" | sed 's/^sops_kms__list_0__map_arn=//')
  sops -d -i  $ADDITIONAL_ARGS "$SECRET_FILE_PATH"
}

delete_secret() {
  sed -i "/^${SECRET_NAME}=/d" "$SECRET_FILE_PATH"
}

# Main function to handle logic
main() {
  if ! secret_file_exists; then
    echo "The secret file doesn't exist."
    exit 1    
  fi
  echo "Decrypting existing secret file..."
  decrypt_file
  echo "Deleting the secret $SECRET_NAME"
  delete_secret
  echo "Encrypting the secret file $SECRET_FILE_PATH"
  encrypt_file
}

main
