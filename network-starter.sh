#!/bin/bash

export HOME_DIR=$(git rev-parse --show-toplevel)
export FABRIC_CFG_PATH="${HOME_DIR}/config"

./network.sh down
./network.sh up createChannel -ca -s couchdb

# # Copy the connection profiles so they are in the correct organizations.
# cp "${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/connection-org1.yaml" "${HOME_DIR}/organizations/org1/gateway/"
# cp "${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/connection-org2.yaml" "${HOME_DIR}/organizations/org2/gateway/"

cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/User1@org1.dealblock.com/msp/signcerts/* ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/User1@org1.dealblock.com/msp/signcerts/User1@org1.dealblock.com-cert.pem
cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/User1@org1.dealblock.com/msp/keystore/* ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/User1@org1.dealblock.com/msp/keystore/priv_sk

cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/User1@org2.dealblock.com/msp/signcerts/* ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/User1@org2.dealblock.com/msp/signcerts/User1@org2.dealblock.com-cert.pem
cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/User1@org2.dealblock.com/msp/keystore/* ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/User1@org2.dealblock.com/msp/keystore/priv_sk
