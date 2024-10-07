#!/bin/bash

if [ -z "$1" ]; then
  echo "usage: $0 <file.tar.enc>"
  exit 1
fi

ENC_FILE=$1
BASENAME=$(basename "$ENC_FILE" .tar.enc)

openssl enc -aes-256-cbc -d -salt -pbkdf2 -iter 10000 -in "$ENC_FILE" -out "$BASENAME.tar"

tar -xf "$BASENAME.tar"

rm "$BASENAME.tar"

echo "$BASENAME"
