#!/bin/bash

if [ -z "$1" ]; then
  echo "usage: $0 <dir>"
  exit 1
fi


DIR=$1

tar -cf "$DIR.tar" "$DIR"

openssl enc -aes-256-cbc -salt -pbkdf2 -iter 10000 -in "$DIR.tar" -out "$DIR.tar.enc"

rm "$DIR.tar"

echo "$DIR.tar.enc"
