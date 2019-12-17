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
docker kill $(docker ps -q)
#删除dev容器镜像
docker rmi $(docker images dev-* -q)
#删除所有docker网络缓存
docker network prune
docker network ls

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
configtxgen -profile TestOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID myc

#更新锚节点
# 每个组织都对应一个锚节点的更新文件
#go组织锚节点文件
configtxgen -profile TestOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org01MSPAnchors.tx -channelID myc -asOrg Org01MSP

#进入cli容器
docker exec -it cli bash
#创建通道
peer channel create -o orderer.test.com:7050 -c myc -f ./channel.tx
#加入通道
peer channel join -b myc.block
peer channel list

#进入chaincode容器
docker exec -it chaincode bash
cd mycc
go build -o mycc01
CORE_PEER_ADDRESS=peer0.org01.test.com:7052 CORE_CHAINCODE_ID_NAME=mycc:1.0 ./mycc
CORE_PEER_ADDRESS=peer0.org01.test.com:7052 CORE_CHAINCODE_ID_NAME=mycc:1.0 go run chaincode_example02.go

#进入cli容器
docker exec -it cli bash
#安装链码
peer chaincode install -p chaincodedev/chaincode/mycc -n mycc -v 1.0
#初始化链码
peer chaincode instantiate -n mycc -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -C myc -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"

#查询链码
peer chaincode query -C myc -n mycc -c '{"Args":["query","a"]}'
peer chaincode query -C myc -n mycc -c '{"Args":["query","b"]}'

#调用链码
#peer chaincode invoke -o orderer节点地址:端口 --tls true --cafile orderer节点pem格式的证书文件 -C 通道名称 -n 链码名称 --peerAddresses 背书节点1:端口 --tlsRootCertFiles 背书节点1的TLS根证书    --peerAddresses 背书节点2:端口 --tlsRootCertFiles 背书节点2的TLS根证书 -c 交易链码调用
peer chaincode invoke -C myc -n mycc -c '{"Args":["invoke","a","b","10"]}'

#参考博客
https://blog.csdn.net/zhayujie5200/article/details/84561825
https://blog.csdn.net/neosmith/article/details/80020740

######################################原始链码安装
#安装链码
#-p	从$GOPATH/src 路径后开始写
peer chaincode install -n mycc -v 1.0 -l golang -p github.com/chaincode

#链码初始化
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C myc -n mycc -l golang -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"

#查询链码
peer chaincode query -C myc -n mycc -c '{"Args":["query","a"]}'
peer chaincode query -C myc -n mycc -c '{"Args":["query","b"]}'

#调用链码
#peer chaincode invoke -o orderer节点地址:端口 --tls true --cafile orderer节点pem格式的证书文件 -C 通道名称 -n 链码名称 --peerAddresses 背书节点1:端口 --tlsRootCertFiles 背书节点1的TLS根证书    --peerAddresses 背书节点2:端口 --tlsRootCertFiles 背书节点2的TLS根证书 -c 交易链码调用
peer chaincode invoke -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem -C myc -n mycc --peerAddresses peer0.org01.test.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org01.test.com/tlsca/tlsca.org01.test.com-cert.pem -c '{"Args":["invoke","a","b","10"]}'

#查看couchdb的web界面
ip:5984/_utils
设置用户名+密码
输入用户名+密码