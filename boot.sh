#!/bin/bash


### Constants and Environment Variables

# Set-up Constants
BOOT_DIR="./boot"
BOOT_NODE_IDENT="sdx_boot"
DEFAULT_PWD_FILE="./data/default-password.txt"
GENESIS_PATH="./data/genesis.json"

# SDX Config
SDX_HTTP_PORT=8000
SDX_PORT=30303
SDX_NET_ID=18930236
SDX_NAT_TYPE="any"


### Main Execution

# Create Bootnode Directory with New Account
if [ ! -d "${BOOT_DIR}" ]
then
  # Create Directory
  mkdir ${BOOT_DIR}

  # Create a New Account
  geth account new --datadir ${BOOT_DIR} --password ${DEFAULT_PWD_FILE}

  # Initialize Boot with Genesis Block
  geth --datadir ${BOOT_DIR} init ${GENESIS_PATH}
fi
  
# Start-Up Boot Node
geth --datadir ${BOOT_DIR} \
	--identity "${BOOT_NODE_IDENT}" \
	--http \
	--http.port ${SDX_HTTP_PORT} \
	--http.api "eth,net,web3,personal,miner,admin" \
	--http.corsdomain "*" \
	--port ${SDX_PORT} \
	--networkid ${SDX_NET_ID} \
	--nat "${SDX_NAT_TYPE}" \
  --allow-insecure-unlock
