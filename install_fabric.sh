#! /bin/bash

install_binaries(){

    curl -sSL http://bit.ly/2ysbOFE -o bootstrap.sh
    chmod 755 ./bootstrap.sh

    bash ./bootstrap.sh  2.1.1 1.4.6 0.4.18

    sudo cp ./fabric-samples/bin/*    /usr/local/bin
    cp -r ./fabric-samples/bin ../
    cp -r ./fabric-samples/commercial-paper .
    cp -r ./fabric-samples/test-network .

    go get github.com/hyperledger/fabric-chaincode-go/shim
    go get github.com/hyperledger/fabric-chaincode-go/shimtest

    rm -fr ./fabric-samples
    rm bootstrap.sh
}

install_binaries
