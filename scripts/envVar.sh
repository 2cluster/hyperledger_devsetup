
# This is a collection of bash functions used by different scripts

export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/msp/tlscacerts/tlsca.dealblock.com-cert.pem
export PEER0_ORG1_CA=${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/tls/ca.crt
export PEER0_ORG2_CA=${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/tls/ca.crt

# Set OrdererOrg.Admin globals
setOrdererGlobals() {
  export CORE_PEER_LOCALMSPID="OrdererMSP"
  export CORE_PEER_TLS_ROOTCERT_FILE=${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/msp/tlscacerts/tlsca.dealblock.com-cert.pem
  export CORE_PEER_MSPCONFIGPATH=${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/users/Admin@dealblock.com/msp
}

# Set environment variables for the peer org
setGlobals() {
  local USING_ORG=""
  if [ -z "$OVERRIDE_ORG" ]; then
    USING_ORG=$1
  else
    USING_ORG="${OVERRIDE_ORG}"
  fi
  echo "Using organization ${USING_ORG}"
  if [ $USING_ORG -eq 1 ]; then
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/Admin@org1.dealblock.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
  elif [ $USING_ORG -eq 2 ]; then
    export CORE_PEER_LOCALMSPID="Org2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/Admin@org2.dealblock.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
  else
    echo "================== ERROR !!! ORG Unknown =================="
  fi

  if [ "$VERBOSE" == "true" ]; then
    env | grep CORE
  fi
}

# parsePeerConnectionParameters $@
# Helper function that sets the peer connection parameters for a chaincode
# operation
parsePeerConnectionParameters() {

  PEER_CONN_PARMS=""
  PEERS=""
  while [ "$#" -gt 0 ]; do
    setGlobals $1
    PEER="peer0.org$1"
    ## Set peer adresses
    PEERS="$PEERS $PEER"
    PEER_CONN_PARMS="$PEER_CONN_PARMS --peerAddresses $CORE_PEER_ADDRESS"
    ## Set path to TLS certificate
    TLSINFO=$(eval echo "--tlsRootCertFiles \$PEER0_ORG$1_CA")
    PEER_CONN_PARMS="$PEER_CONN_PARMS $TLSINFO"
    # shift by one to get to the next organization
    shift
  done
  # remove leading space for output
  PEERS="$(echo -e "$PEERS" | sed -e 's/^[[:space:]]*//')"
}

verifyResult() {
  if [ $1 -ne 0 ]; then
    echo "!!!!!!!!!!!!!!! "$2" !!!!!!!!!!!!!!!!"
    echo
    exit 1
  fi
}
