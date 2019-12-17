#生成证书配置文件模板
cryptogen --help
cryptogen generate --help
cryptogen showtemplate > crypto-config.yaml
#默认配置文件生成证书文件
cryptogen generate 
#自定义配置文件生成证书文件
cryptogen generate --config=crypto-config.yaml

#创始块+通道配置文件模板
mkdir channel-artifacts
#生成创世块文件
configtxgen -profile TestOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

#生成通道文件
configtxgen -profile TestOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel03

#更新锚节点
# 每个组织都对应一个锚节点的更新文件
#go组织锚节点文件
configtxgen -profile TestOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org01MSPAnchors.tx -channelID mychannel03 -asOrg Org01MSP

#testwork与文件夹同名
CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=demo02_byfn

#创建base文件夹存放peer-base.yaml+docker-compose-base.yaml
mkdir base
mv docker-compose-base.yaml peer-base.yaml ./base

#docker-compose启动容器
docker-compose -f docker-compose-cli.yaml up -d
docker-compose up -d
#查看docker-compose启动容器情况
docker-compose -f docker-compose-cli.yaml ps
docker-compose ps
#关闭docker-compose启动容器
docker-compose -f docker-compose-cli.yaml down -v
docker-compose down -v
#删除所有容器
docker rm -f $(docker ps -aq)
docker rm $(docker ps -a -q)

#进入cli容器
docker exec -it cli bash

#客户端cli
#创建通道
peer channel create -o orderer.test.com:7050 -c mychannel03 -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem

#客户端cli操作peer节点
#加入通道
peer channel join -b mychannel03.block
peer channel list

#安装链码
#-p	从$GOPATH/src 路径后开始写
peer chaincode install -n mychaincode03 -v 1.0 -l golang -p github.com/chaincode

#链码初始化
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C mychannel03 -n mychaincode03 -l golang -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"

#查询链码
peer chaincode query -C mychannel03 -n mychaincode03 -c '{"Args":["query","a"]}'
peer chaincode query -C mychannel03 -n mychaincode03 -c '{"Args":["query","b"]}'

#调用链码
#peer chaincode invoke -o orderer节点地址:端口 --tls true --cafile orderer节点pem格式的证书文件 -C 通道名称 -n 链码名称 --peerAddresses 背书节点1:端口 --tlsRootCertFiles 背书节点1的TLS根证书    --peerAddresses 背书节点2:端口 --tlsRootCertFiles 背书节点2的TLS根证书 -c 交易链码调用
peer chaincode invoke -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem -C mychannel03 -n mychaincode03 --peerAddresses peer0.org01.test.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org01.test.com/tlsca/tlsca.org01.test.com-cert.pem -c '{"Args":["invoke","a","b","10"]}'
