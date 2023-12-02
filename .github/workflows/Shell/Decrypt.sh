#!/bin/bash


# master.key
gpg -d -o "$DECRYPTED_MASTER_KEY_PATH" --pinentry-mode=loopback --passphrase "$GPG_KEY" "$ENCRYPTED_MASTER_KEY_PATH"

# fastlane env
gpg -d -o "$DECRYPTED_FASTLANE_ENV_PATH" --pinentry-mode=loopback --passphrase "$GPG_KEY" "$ENCRYPTED_FASTLANE_ENV_PATH"

# googleService
gpg -d -o "$DECRYPTED_GOOGLE_SERVICE_PATH" --pinentry-mode=loopback --passphrase "$GPG_KEY" "$ENCRYPTED_GOOGLE_SERVICE_PATH"