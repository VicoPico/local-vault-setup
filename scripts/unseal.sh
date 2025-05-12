#!/bin/bash

echo "Enter unseal key:"
read -s UNSEAL_KEY

vault operator unseal $UNSEAL_KEY