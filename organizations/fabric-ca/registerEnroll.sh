

function createOrg1 {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/

	export FABRIC_CA_CLIENT_HOME=${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-org1 --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1.pem
    OrganizationalUnitIdentifier: orderer' > ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/msp/config.yaml

  echo
	echo "Register peer0"
  echo
  set -x
	fabric-ca-client register --caname ca-org1 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  echo
  echo "Register user"
  echo
  set -x
  fabric-ca-client register --caname ca-org1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  echo
  echo "Register the org admin"
  echo
  set -x
  fabric-ca-client register --caname ca-org1 --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

	mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers
  mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com

  echo
  echo "## Generate the peer0 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-org1 -M ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/msp --csr.hosts peer0.org1.dealblock.com --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/msp/config.yaml ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-org1 -M ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/tls --enrollment.profile tls --csr.hosts peer0.org1.dealblock.com --csr.hosts localhost --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org1/tls-cert.pem
  set +x


  cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/tls/tlscacerts/* ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/tls/ca.crt
  cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/tls/signcerts/* ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/tls/server.crt
  cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/tls/keystore/* ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/tls/server.key

  mkdir ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/msp/tlscacerts
  cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/tls/tlscacerts/* ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/msp/tlscacerts/ca.crt

  mkdir ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/tlsca
  cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/tls/tlscacerts/* ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/tlsca/tlsca.org1.dealblock.com-cert.pem

  mkdir ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/ca
  cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/peers/peer0.org1.dealblock.com/msp/cacerts/* ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/ca/ca.org1.dealblock.com-cert.pem

  mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users
  mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/User1@org1.dealblock.com

  echo
  echo "## Generate the user msp"
  echo
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-org1 -M ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/User1@org1.dealblock.com/msp --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/msp/config.yaml ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/User1@org1.dealblock.com/msp/config.yaml

  mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/Admin@org1.dealblock.com

  echo
  echo "## Generate the org admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7054 --caname ca-org1 -M ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/Admin@org1.dealblock.com/msp --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org1/tls-cert.pem
  set +x

  cp ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/msp/config.yaml ${HOME_DIR}/organizations/peerOrganizations/org1.dealblock.com/users/Admin@org1.dealblock.com/msp/config.yaml

}


function createOrg2 {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/

	export FABRIC_CA_CLIENT_HOME=${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/
#  rm -rf $FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml
#  rm -rf $FABRIC_CA_CLIENT_HOME/msp

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca-org2 --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2.pem
    OrganizationalUnitIdentifier: orderer' > ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/msp/config.yaml

  echo
	echo "Register peer0"
  echo
  set -x
	fabric-ca-client register --caname ca-org2 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  echo
  echo "Register user"
  echo
  set -x
  fabric-ca-client register --caname ca-org2 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  echo
  echo "Register the org admin"
  echo
  set -x
  fabric-ca-client register --caname ca-org2 --id.name org2admin --id.secret org2adminpw --id.type admin --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

	mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers
  mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com

  echo
  echo "## Generate the peer0 msp"
  echo
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-org2 -M ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/msp --csr.hosts peer0.org2.dealblock.com --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/msp/config.yaml ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-org2 -M ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/tls --enrollment.profile tls --csr.hosts peer0.org2.dealblock.com --csr.hosts localhost --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org2/tls-cert.pem
  set +x


  cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/tls/tlscacerts/* ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/tls/ca.crt
  cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/tls/signcerts/* ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/tls/server.crt
  cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/tls/keystore/* ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/tls/server.key

  mkdir ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/msp/tlscacerts
  cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/tls/tlscacerts/* ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/msp/tlscacerts/ca.crt

  mkdir ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/tlsca
  cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/tls/tlscacerts/* ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/tlsca/tlsca.org2.dealblock.com-cert.pem

  mkdir ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/ca
  cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/peers/peer0.org2.dealblock.com/msp/cacerts/* ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/ca/ca.org2.dealblock.com-cert.pem

  mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users
  mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/User1@org2.dealblock.com

  echo
  echo "## Generate the user msp"
  echo
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-org2 -M ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/User1@org2.dealblock.com/msp --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/msp/config.yaml ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/User1@org2.dealblock.com/msp/config.yaml

  mkdir -p ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/Admin@org2.dealblock.com

  echo
  echo "## Generate the org admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://org2admin:org2adminpw@localhost:8054 --caname ca-org2 -M ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/Admin@org2.dealblock.com/msp --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/org2/tls-cert.pem
  set +x

  cp ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/msp/config.yaml ${HOME_DIR}/organizations/peerOrganizations/org2.dealblock.com/users/Admin@org2.dealblock.com/msp/config.yaml

}

function createOrderer {

  echo
	echo "Enroll the CA admin"
  echo
	mkdir -p ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com

	export FABRIC_CA_CLIENT_HOME=${HOME_DIR}/organizations/ordererOrganizations/dealblock.com
#  rm -rf $FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml
#  rm -rf $FABRIC_CA_CLIENT_HOME/msp

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' > ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/msp/config.yaml


  echo
	echo "Register orderer"
  echo
  set -x
	fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/ordererOrg/tls-cert.pem
    set +x

  echo
  echo "Register the orderer admin"
  echo
  set -x
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

	mkdir -p ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers
  mkdir -p ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/dealblock.com

  mkdir -p ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com

  echo
  echo "## Generate the orderer msp"
  echo
  set -x
	fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/msp --csr.hosts orderer.dealblock.com --csr.hosts localhost --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/msp/config.yaml ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/tls --enrollment.profile tls --csr.hosts orderer.dealblock.com --csr.hosts localhost --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/tls/tlscacerts/* ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/tls/ca.crt
  cp ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/tls/signcerts/* ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/tls/server.crt
  cp ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/tls/keystore/* ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/tls/server.key

  mkdir ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/msp/tlscacerts
  cp ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/tls/tlscacerts/* ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/msp/tlscacerts/tlsca.dealblock.com-cert.pem

  mkdir ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/msp/tlscacerts
  cp ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/orderers/orderer.dealblock.com/tls/tlscacerts/* ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/msp/tlscacerts/tlsca.dealblock.com-cert.pem

  mkdir -p ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/users
  mkdir -p ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/users/Admin@dealblock.com

  echo
  echo "## Generate the admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/users/Admin@dealblock.com/msp --tls.certfiles ${HOME_DIR}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  set +x

  cp ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/msp/config.yaml ${HOME_DIR}/organizations/ordererOrganizations/dealblock.com/users/Admin@dealblock.com/msp/config.yaml


}