#!/bin/bash
set -e
# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1
starttime=$(date +%s)
LANGUAGE=node
CC_SRC_PATH=/opt/gopath/src/github.com/fishcc
# clean the keystore
rm -rf ./hfc-key-store
# launch network; create channel and join peer to channel
cd ../basic-network
./start.sh
# Now launch the CLI container in order to install, instantiate chaincode
docker-compose -f ./docker-compose.yml up -d cli
cd ../chaincode/fishcc
CORE_CHAINCODE_ID_NAME="fishcc:1.0"  npm start -- --peer.address grpc://172.17.0.1:7052



