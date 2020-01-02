#############GoLocal04_Trace
#生成证书配置文件模板
cryptogen --help
cryptogen generate --help
cryptogen showtemplate > crypto-config.yaml
#默认配置文件生成证书文件
cryptogen generate 
#自定义配置文件生成证书文件
cryptogen generate --config=crypto-config.yaml

#创始块+通道配置文件模板
configtxgen --help 
configtx.yaml名字是固定的
/home/roger/hyperledger-fabric/fabric-samples/first-network/configtx.yaml
#创建创始块+通道文件文件夹
mkdir channel-artifacts
#生成创世块文件
configtxgen -profile OrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

#生成通道文件
configtxgen -profile OrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

#更新锚节点
# 每个组织都对应一个锚节点的更新文件
#组织锚节点文件
configtxgen -profile OrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/OrgDairyMSPAnchors.tx -channelID mychannel -asOrg OrgDairyMSP
configtxgen -profile OrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/OrgProcessMSPAnchors.tx -channelID mychannel -asOrg OrgProcessMSP
configtxgen -profile OrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/OrgSellMSPAnchors.tx -channelID mychannel -asOrg OrgSellMSP

#将cli容器中的channel.block文件拷贝到本机
docker cp cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/testchannel.block ./
#远程主机间拷贝文件
scp ./helloworld.txt roger@192.168.150.20:/home/roger/solowork
#远程主机间拷贝文件夹
scp -r ./helloworld.txt roger@192.168.150.20:/home/roger/solowork

#解决多级多节点，链码指纹不匹配。
#进入cli容器
docker exec -it cli up bash
docker exec -it cli /bin/bash
#链码打包
peer chaincode  -n testgochaincode -p github.com/chaincode -v 1.0 testgochaincode.1.0.out
#将cli容器中的channel.block文件拷贝到本机
docker cp cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/testgochaincode.1.0.out ./
#远程主机间拷贝文件
scp ./helloworld.txt roger@192.168.150.20:/home/roger/solowork/channel-artifacts
#进入cli容器
docker exec -it cli up bash
docker exec -it cli /bin/bash
#安装链码
peer install ./channel-artifacts/testgochaincode.1.0.out

#docker-compose-cli.yaml配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/first-network/docker-compose-cli.yaml
#docker-compose-base.yaml配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/first-network/base/docker-compose-base.yaml
#peer-base.yaml配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/first-network/base/peer-base.yaml
#fabric-ca配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/basic-network/docker-compose.yaml

#testwork与文件夹同名
CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=trace_byfn

#docker-compose启动容器
docker-compose -f docker-compose-cli.yaml up -d
docker-compose up -d
docker-compose up 
#查看docker-compose启动容器情况
docker-compose -f docker-compose-cli.yaml ps
docker-compose ps
docker-compose -f docker-orderer.yaml -f docker-peer0-process.yaml -f docker-peer1-dairy.yaml -f docker-peer1-sell.yaml -f docker-peer0-dairy.yaml -f docker-peer0-sell.yaml -f docker-peer1-process.yaml ps

#关闭docker-compose启动容器
docker-compose -f docker-compose-cli.yaml down -v
docker-compose down -v
docker-compose down 
#删除所有容器
docker rm -f $(docker ps -aq)
docker rm $(docker ps -a -q)
docker rm `docker ps -aq` -fv #强制删除所有容器，以及相关挂载卷缓存
docker kill $(docker ps -q)
#删除dev容器镜像
docker rmi $(docker images dev-* -q)
#删除所有docker网络缓存
docker network prune
docker volume prune
docker network ls

#进入cli容器
docker exec -it cli bash
docker exec -it cli /bin/bash

#客户端cli
#创建通道
peer channel create -o orderer.trace.com:7050 -c mychannel -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/tlsca/tlsca.trace.com-cert.pem

#客户端cli操作peer节点
#加入通道
peer channel join -b mychannel.block
peer channel join -b mychannel.block
peer channel list

#修改cli客户端环境变量，切换cli节点容器连接的peer节点
envChange.sh
#查看cli客户端连接的是哪个peer节点
echo $CORE_PEER_ADDRESS
#查看cli客户端连接的是哪个组织节点
echo $CORE_PEER_LOCALMSPID

#锚节点更新(可选）
#修改cli客户端环境变量，切换cli节点容器连接的peer节点
envChange.sh
#查看cli客户端连接的是哪个peer节点
echo $CORE_PEER_ADDRESS
#查看cli客户端连接的是哪个组织节点
echo $CORE_PEER_LOCALMSPID
#更新锚节点
peer channel update -o orderer.trace.com:7050 -c mychannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/CppMSPAnchors.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/tlsca/tlsca.trace.com-cert.pem
peer channel update -o orderer.trace.com:7050 -c mychannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/GoMSPAnchors.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/tlsca/tlsca.trace.com-cert.pem

#chaincode模板
/home/roger/hyperledger-fabric/fabric-samples/chaincode
/home/roger/hyperledger-fabric/fabric-samples/chaincode/chaincode_example02/go
#创建chaincode文件文件夹，存放chaincode
mkdir chaincode
#拷贝chaincode文件至chaincode文件夹
sudo cp chaincode_example02.go ~/testwork/chaincode/
sudo mv chaincode_example02.go testgochaincode.go

#安装链码
#-p	从$GOPATH/src 路径后开始写
peer chaincode install -n dairychaincode -v 1.0 -l golang -p github.com/chaincode/dairy
peer chaincode install -n processchaincode -v 1.0 -l golang -p github.com/chaincode/process
peer chaincode install -n sellchaincode -v 1.0 -l golang -p github.com/chaincode/sell

#修改cli客户端环境变量，切换cli节点容器连接的peer节点
envChange.sh
#查看cli客户端连接的是哪个peer节点
echo $CORE_PEER_ADDRESS
#查看cli客户端连接的是哪个组织节点
echo $CORE_PEER_LOCALMSPID

#链码初始化
peer chaincode instantiate -o orderer.trace.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/msp/tlscacerts/tlsca.trace.com-cert.pem  -C mychannel -n dairychaincode -l golang -v 1.0 -c '{"Args":["init","a"]}' -P "AND ('OrgDairyMSP.member')"

peer chaincode instantiate -o orderer.trace.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/msp/tlscacerts/tlsca.trace.com-cert.pem  -C mychannel -n processchaincode -l golang -v 1.0 -c '{"Args":["init","a"]}' -P "AND ('OrgProcessMSP.member')"

peer chaincode instantiate -o orderer.trace.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/msp/tlscacerts/tlsca.trace.com-cert.pem  -C mychannel -n sellchaincode -l golang -v 1.0 -c '{"Args":["init","a"]}' -P "AND ('OrgSellMSP.member')"

#查询链码
peer chaincode invoke -o orderer.trace.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/tlsca/tlsca.trace.com-cert.pem -C mychannel -n dairychaincode --peerAddresses peer0.dairy.trace.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/dairy.trace.com/peers/peer0.dairy.trace.com/tls/ca.crt -c '{"Args":["invoke","getvalue","dairyA",""]}'

peer chaincode invoke -o orderer.trace.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/tlsca/tlsca.trace.com-cert.pem -C mychannel -n processchaincode --peerAddresses peer0.process.trace.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/process.trace.com/peers/peer0.process.trace.com/tls/ca.crt -c '{"Args":["invoke","getvalue","processA",""]}'

peer chaincode invoke -o orderer.trace.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/tlsca/tlsca.trace.com-cert.pem -C mychannel -n sellchaincode --peerAddresses peer0.sell.trace.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/sell.trace.com/peers/peer0.sell.trace.com/tls/ca.crt -c '{"Args":["invoke","getvalue","sellA",""]}'



#调用链码
peer chaincode invoke -o orderer.trace.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/tlsca/tlsca.trace.com-cert.pem -C mychannel -n dairychaincode --peerAddresses peer0.dairy.trace.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/dairy.trace.com/peers/peer0.dairy.trace.com/tls/ca.crt -c '{"Args":["invoke","putvalue","dairyA","A"]}'

peer chaincode invoke -o orderer.trace.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/tlsca/tlsca.trace.com-cert.pem -C mychannel -n processchaincode --peerAddresses peer0.process.trace.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/process.trace.com/peers/peer0.process.trace.com/tls/ca.crt -c '{"Args":["invoke","putvalue","processA","dairyA"]}'

peer chaincode invoke -o orderer.trace.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/trace.com/tlsca/tlsca.trace.com-cert.pem -C mychannel -n sellchaincode --peerAddresses peer0.sell.trace.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/sell.trace.com/peers/peer0.sell.trace.com/tls/ca.crt -c '{"Args":["invoke","putvalue","sellA","processA"]}'