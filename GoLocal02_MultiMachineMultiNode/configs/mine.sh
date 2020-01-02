#############GoLocal02_MultiMachineMultiNode
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
configtxgen -profile mmmnOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

#生成通道文件
configtxgen -profile mmmnOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

#更新锚节点
# 每个组织都对应一个锚节点的更新文件
#go组织锚节点文件
configtxgen -profile mmmnOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/GoMSPAnchors.tx -channelID mychannel -asOrg OrgGoMSP

#cpp组织锚节点文件
configtxgen -profile mmmnOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/CppMSPAnchors.tx -channelID mychannel -asOrg OrgCppMSP

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
CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=testwork_byfn

#docker-compose启动容器
docker-compose -f docker-compose-cli.yaml up -d
docker-compose up -d
docker-compose up 
#查看docker-compose启动容器情况
docker-compose -f docker-compose-cli.yaml ps
docker-compose ps
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
docker network ls

#进入cli容器
docker exec -it cli bash
docker exec -it cli /bin/bash

#客户端cli
#创建通道
peer channel create -o orderer.test.com:7050 -c mychannel -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem

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
peer channel update -o orderer.test.com:7050 -c mychannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/CppMSPAnchors.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem
peer channel update -o orderer.test.com:7050 -c mychannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/GoMSPAnchors.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem

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
peer chaincode install -n testchaincode -v 1.0 -l golang -p github.com/chaincode

#修改cli客户端环境变量，切换cli节点容器连接的peer节点
envChange.sh
#查看cli客户端连接的是哪个peer节点
echo $CORE_PEER_ADDRESS
#查看cli客户端连接的是哪个组织节点
echo $CORE_PEER_LOCALMSPID

#链码初始化
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C mychannel -n testchaincode -l golang -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('OrgGoMSP.member', 'OrgCppMSP.member')"

#查询链码
peer chaincode query -C mychannel -n testchaincode -c '{"Args":["query","a"]}'
peer chaincode query -C mychannel -n testchaincode -c '{"Args":["query","b"]}'

#调用链码
peer chaincode invoke -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem -C mychannel -n testchaincode --peerAddresses peer0.orggo.test.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/orggo.test.com/tlsca/tlsca.orggo.test.com-cert.pem --peerAddresses peer0.orgcpp.test.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/orgcpp.test.com/tlsca/tlsca.orgcpp.test.com-cert.pem -c '{"Args":["invoke","a","b","10"]}'
