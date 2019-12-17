####################################################阿里云BasicNetWorkDev
#购买阿里云
固定带宽1M
#更新软件源列表
apt-get update
#安装git
apt-get install git
#安装docker-ce
请不要直接apt-get 安装docker, 这会安装docker的旧版本 如果安装了docker的旧版本,请参考卸载文档
https://yq.aliyun.com/articles/110806?spm=5176.8351553.0.0.5d4e1991URD8Ia
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
#安装hyperledger fabric
安装hyperledger的工具和docker镜像官方文档
http://hyperledger-fabric.readthedocs.io/en/release-1.1/samples.html#binaries
curl -sSL https://goo.gl/6wtTN5 | bash -s 1.1.0
goo.gl短地址被墙, 服务器需要翻墙. 或者直接采用下面解析后的地址
https://raw.githubusercontent.com/hyperledger/fabric/master/scripts/bootstrap.sh
https://raw.githubusercontent.com/itheima1/BlockChain/master/tools/bootstrap.sh
个镜像下载失败, 原因是0.4.10的 zookeeper 和 kafka couchdb并没有同步到仓库，
fabric-ca1.2版本也没有同步到仓库，建议使用黑马程序员修改的sh脚本。
curl -sSL https://raw.githubusercontent.com/itheima1/BlockChain/master/tools/bootstrap.sh | bash -s 1.1.0
#安装docker-compose
curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
参考文档 https://github.com/docker/compose/releases
#阿里云问题
解决网络报错问题：阿里云的服务器是改良过的linux服务器, 里面有一句网络超时的配置需要注释掉。
注意,如果是原版的Ubuntu服务器或者用腾讯云,aws的服务器, 这个错误是不会出现的。
vim /etc/resolv.conf 
注释掉 #options timeout:2 attempts:3 rotate single-request-reopen 
#启动end2end网络
cd fabric-samples
cd first-network
./byfn.sh -m generate
./byfn.sh -m up
./byfn.sh -m down
#BasicNetWork参考
https://github.com/itheima1/hyperledger

#BasicNetWork相关语句
ifconfig 
docker0的ip:172.17.0.1

#mycc
CORE_CHAINCODE_ID_NAME="mycc:v0"  npm start -- --peer.address grpc://172.17.0.1:7052

docker exec -it cli bash

CORE_PEER_LOCALMSPID=Org1MSP CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer chaincode install -l node -n mycc -v v0 -p /opt/gopath/src/github.com/mycc/

CORE_PEER_LOCALMSPID=Org1MSP CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer chaincode instantiate -l node -n mycc -v v0 -C mychannel -c '{"args":["init","zzh","100","czbk","100"]}' -o 172.17.0.1:7050

CORE_PEER_LOCALMSPID=Org1MSP CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer chaincode invoke -n mycc -v v0 -C mychannel -c '{"args":["invoke","zzh","czbk","100"]}' -o 172.17.0.1:7050

CORE_PEER_LOCALMSPID=Org1MSP CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer chaincode invoke -n mycc -v v0 -C mychannel -c '{"args":["query","zzh"]}' -o 172.17.0.1:7050

CORE_PEER_LOCALMSPID=Org1MSP CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer chaincode invoke -n mycc -v v0 -C mychannel -c '{"args":["query","czbk"]}' -o 172.17.0.1:7050

#myfish
CORE_CHAINCODE_ID_NAME="myfish:v0"  npm start -- --peer.address grpc://172.17.0.1:7052

docker exec -it cli bash

CORE_PEER_LOCALMSPID=Org1MSP CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer chaincode install -l node -n myfish -v v0 -p /opt/gopath/src/github.com/myfish/

CORE_PEER_LOCALMSPID=Org1MSP CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer chaincode instantiate -l node -n myfish -v v0 -C mychannel -c '{"args":[""]}' -o 172.17.0.1:7050

CORE_PEER_LOCALMSPID=Org1MSP CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer chaincode invoke -n myfish -v v0 -C mychannel -c '{"args":["initLedger"]}' -o 172.17.0.1:7050

CORE_PEER_LOCALMSPID=Org1MSP CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer chaincode invoke -n myfish -v v0 -C mychannel -c '{"args":["queryFish","FISH1"]}' -o 172.17.0.1:7050

CORE_PEER_LOCALMSPID=Org1MSP CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer chaincode invoke -n myfish -v v0 -C mychannel -c '{"args":["queryAllFish"]}' -o 172.17.0.1:7050
