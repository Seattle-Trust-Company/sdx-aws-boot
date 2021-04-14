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
SDX_FAKE_ENODE="enode://91c024f766b46345953e2892e46ff6bc1dd507de48fcef3f176467d7ecdc1e38b99d6ce14ecf8f6d51149d507b695a973f91c6ba91b9f09f41ae8de16747578c@127.0.0.1:0?discport=30000"


### Main Execution

# Create Node Directory
if [ ! -d "${BOOT_DIR}" ]
then
  echo "Creating ${BOOT_DIR}"
  mkdir ${BOOT_DIR}
fi

# Create a New Account
if [ ! -d "${BOOT_DIR}/keystore" ]
then
  echo "Creating New Account"
  geth account new --datadir ${BOOT_DIR} --password ${DEFAULT_PWD_FILE}
fi

# Initialize Boot with Genesis Block
if [ ! -d "${BOOT_DIR}/geth" ]
then
  echo "Syncing Node with Genesis Block"
  geth --datadir ${BOOT_DIR} init ${GENESIS_PATH}
fi
 
# Print Command
echo 'Running Command'
echo "
geth \
	--identity \"${BOOT_NODE_IDENT}\" \
  --datadir ${BOOT_DIR} \
	--http \
	--http.port ${SDX_HTTP_PORT} \
	--http.api \"eth,net,web3,personal,miner,admin\" \
	--http.corsdomain \"*\" \
	--port ${SDX_PORT} \
	--networkid ${SDX_NET_ID} \
	--nat \"${SDX_NAT_TYPE}\" \
  --allow-insecure-unlock \
  --verbosity 6 \
  --nodekey boot.key \
  --bootnodes \"${SDX_FAKE_ENODE}\"
"

# Start-Up Boot Node
geth \
	--identity "${BOOT_NODE_IDENT}" \
  --datadir ${BOOT_DIR} \
	--http \
	--http.port ${SDX_HTTP_PORT} \
	--http.api "eth,net,web3,personal,miner,admin" \
	--http.corsdomain "*" \
	--port ${SDX_PORT} \
	--networkid ${SDX_NET_ID} \
	--nat "${SDX_NAT_TYPE}" \
  --allow-insecure-unlock \
  --verbosity 6 \
  --nodekey boot.key \
  --bootnodes "${SDX_FAKE_ENODE}"

