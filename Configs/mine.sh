####################################################阿里云安装fabric
#开发环境搭建
docker
docker-compose
git
nodejs

#安装docker
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
#安装docker-compose
curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
#安装git
apt-get update
apt-get install git
#安装nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs


#修复阿里云超时bug
vim /etc/resolv.conf 
注释掉 options timeout:2 attempts:3 rotate single-request-reopen 


#下载二进制脚本和安装docker镜像
#curl -sSL https://raw.githubusercontent.com/itheima1/BlockChain/master/tools/bootstrap.sh | bash -s 1.1.0
chmod 777 ./download.sh
bash ./download.sh -s 1.1.0
####################################################阿里云End2End
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
#启动测试end2end网络
cd fabric-samples
cd first-network
./byfn.sh -m generate
./byfn.sh -m up
./byfn.sh -m down
#添加org3测试end2end网络
cd fabric-samples
cd first-network
./eyfn.sh -m generate
./eyfn.sh -m up
./eyfn.sh -m down

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

####################################################阿里云FirstNetWork
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
#启动测试end2end网络
cd fabric-samples
cd first-network
./byfn.sh -m generate
./byfn.sh -m up

#清除网络
./byfn.sh -m down

#参考资料
https://github.com/itheima1/hyperledger
hyperledger-fabric java day03.md

#创建项目文件
cd fabric-samples
mkdir my-first-network
cd my-first-network
#设置二进制文件环境变量
export PATH=/root/fabric-samples/bin:$PATH
#生成证书文件
cryptogen generate --config ./crypto-config.yaml
#生成创世块文件
mkdir channel-artifacts
configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
#生成通道文件
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel
#生成锚节点文件
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID mychannel -asOrg Org2MSP
#设置环境变量
方案一：
如果报错说IMAGE_TAG没有指定,COMPOSE_PROJECT_NAME没有自动,添加指令,指定IMAGE_TAG,COMPOSE_PROJECT_NAME
export IMAGE_TAG=latest
export COMPOSE_PROJECT_NAME=net
方案二：
rz .env
方案三：
在文件中改写
#启动网络+查看
docker-compose -f docker-compose-cli.yaml up
docker-compose -f docker-compose-cli.yaml ps
#进入cli容器
docker exec -it cli bash
#创建通道
CORE_PEER_LOCALMSPID="Org1MSP" CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp peer channel create -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/channel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem
#加入通道
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
peer channel join -b mychannel.block

export CORE_PEER_ADDRESS=peer1.org1.example.com:7051
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
peer channel join -b mychannel.block

export CORE_PEER_ADDRESS=peer0.org2.example.com:7051
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
peer channel join -b mychannel.block


export CORE_PEER_ADDRESS=peer1.org2.example.com:7051
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
peer channel join -b mychannel.block

#安装链码
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
peer chaincode install -n mycc -v 1.0 -l node -p /opt/gopath/src/github.com/chaincode/chaincode_example02/node


export CORE_PEER_ADDRESS=peer1.org1.example.com:7051
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
peer chaincode install -n mycc -v 1.0 -l node -p /opt/gopath/src/github.com/chaincode/chaincode_example02/node

export CORE_PEER_ADDRESS=peer0.org2.example.com:7051
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
peer chaincode install -n mycc -v 1.0 -l node -p /opt/gopath/src/github.com/chaincode/chaincode_example02/node


export CORE_PEER_ADDRESS=peer1.org2.example.com:7051
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
peer chaincode install -n mycc -v 1.0 -l node -p /opt/gopath/src/github.com/chaincode/chaincode_example02/node

#实例化链码
peer chaincode instantiate -o orderer.example.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n mycc -l node -v 1.0 -c '{"Args":["init","a", "100", "b","200"]}' -P "OR ('Org1MSP.member','Org2MSP.member')"

#查询链码
peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'

#调用链码
peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n mycc -c '{"Args":["invoke","a","b","10"]}' --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

####################################################AliYun04_FishNetDevCodeNodeCaCouchNodeSDKBasic
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
#启动测试end2end网络
cd fabric-samples
cd first-network
./byfn.sh -m generate
./byfn.sh -m up

#清除网络
./byfn.sh -m down
./stop.sh
./teardown.sh

#参考资料
https://github.com/itheima1/hyperledger
hyperledger-fabric java day03.md + day04.md

#设置二进制文件环境变量
export PATH=/root/fabric-samples/bin:$PATH

#设置环境变量
方案一：
如果报错说IMAGE_TAG没有指定,COMPOSE_PROJECT_NAME没有自动,添加指令,指定IMAGE_TAG,COMPOSE_PROJECT_NAME
export IMAGE_TAG=latest
export COMPOSE_PROJECT_NAME=net
方案二：
rz .env
方案三：
在文件中改写

#安装nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

#启动网络+查看
docker-compose -f docker-compose-cli.yaml up
docker-compose -f docker-compose-cli.yaml ps

#创建basic-network
mkdir fish-network
cd fish-network
cp -r /root/fabric-samples/basic-network ./
cd basic-network
vim docker-compose-cli.yaml

#创建chaincode
cd ..
mkdir chaincode
cd chaincode
mkdir fishcc 
cd fishcc
npm init
npm install --save fabric-shim --registry=https://registry.npm.taobao.org
vim package.json
"scripts": {
    "start": "node fishcc.js"
  },

#创建webapp
cd ..
mkdir webapp
cd webapp
##启动+初始化网络
rz startApp.sh
rz initLedger.sh
./startApp.sh
./initLedger.sh

#cli命令行调用
docker exec -it cli bash
peer chaincode invoke -C mychannel -n fishcc -c '{"Args":["queryAllFish"]}'
peer chaincode invoke -C mychannel -n fishcc -c '{"Args":["queryFish","FISH1"]}'
peer chaincode invoke -C mychannel -n fishcc -c '{"Args":["recordFish","FISH6","钓鱼岛58B","77.9034, -75.3455","1504054888","Roger"]}'
peer chaincode invoke -C mychannel -n fishcc -c '{"Args":["changeFishHolder","FISH1","Roger"]}'

##SDK调用
npm init
npm install --save fabric-ca-client
npm install --save fabric-client
npm install --save grpc

cp /root/fabric-samples/fabcar/enrollAdmin.js  ./
cp /root/fabric-samples/fabcar/registerUser.js  ./
node enrollAdmin.js
node registerUser.js

rz invokeFish.js 
rz queryFish.js

###query
queryFish
node queryFish.js queryFish "FISH1"
queryAllFish
node queryFish.js queryAllFish ""

###invoke
recordFish
invokeFish.js recordFish "FISH9&王大壮&67.0006, -70.5476&1504054225&奋进号38A"
changeFishHolder
node invokeFish.js changeFishHolder "FISH2&WTF"

#express调用
rz appServer.js
rz appServerQueryFish.js
node appServer.js 
http://47.88.50.237:3002/queryAllFish

#react前后端分离调用
npm install -g cnpm --registry=https://registry.npm.taobao.org
npm config set registry https://registry.npm.taobao.org
cnpm install -g create-react-app
create-react-app app-client
cd app-client/
npm start
npm stop

cd src/
rz App.js

##跨域处理
https://www.jianshu.com/p/ac9c58cee838
cd ..
cd cors/
npm install --save axios
npm install --save koa-compose
npm install --save koa-router
npm install --save koa
npm install --save koa2-cors

rz query.js router.js server.js
node server.js

##测试
npm start

http://47.88.50.237:3000/queryAllFish
http://47.88.50.237:3001/queryAllFish
http://47.88.50.237:3002/queryAllFish


####################################################本地安装fabric
# 创建放置的目录，然后进入该目录，用curl下载脚本。
cd ~ # 这里在家目录下创建放置目录
mkdir hyperledger-fabric # 创建放置目录
cd hyperledger-fabric
# 下载并执行脚本, [ ***语法格式*** ] - 
# 下边是具体的执行命令 - 看我
# 下边是具体的执行命令 - 看我
# 下边是具体的执行命令 -- 重要的事情说三遍, 使用下边不翻墙的命令
curl -sSL http://bit.ly/2ysbOFE | bash -s <fabric> <fabric-ca> <thirdparty>
	- fabric: fabric的版本
	- fabric-ca: fabric-ca的版本
	- thirdparty: 第三方库的版本
# 下载并执行脚本, [ ***需要翻墙, 需要翻墙, 需要翻墙, 需要翻墙, 需要翻墙,*** ]
curl -sSL http://bit.ly/2ysbOFE | bash -s 1.2.0 1.2.0 0.4.10
	- http://bit.ly/2ysbOFE: 该地址必须翻墙才能访问
# ***不翻墙的方式***
curl -sSL https://raw.githubusercontent.com/hyperledger/fabric/master/scripts/bootstrap.sh | bash -s 1.2.0 1.2.0 0.4.10
# 该脚本启动之后会下载两个压缩包和一些镜像文件, 整个过程会比较长, 耐心等待...
# 温馨提示: 这个过程会让你产生想要砸电脑的冲动, 控制好你的情绪!!!!
# 上述命令刚开始会下载以下两个压缩包, 这两个包下载速度特别慢慢慢慢慢慢慢.......
# 	1. hyperledger-fabric-linux-amd64-1.2.0.tar.gz
# 	2. hyperledger-fabric-ca-linux-amd64-1.2.0.tar.gz
#以上两个压缩包下载下来之后会被解压, 解压目录:
~/hyperledger-fabric/fabric-samples
#可以将事先下载好的两个压缩包放到该目录下, 提高下载速度 (强烈建议), 放好之后再重新执行上边的curl命令
#启动测试end2end网络
cd fabric-samples
cd first-network
./byfn.sh -m generate
./byfn.sh -m up

#清除网络
./byfn.sh -m down
./stop.sh
./teardown.sh

#chaincode就是智能合约, 通过编写纯函数的代码,更新ledger的状态.
https://fabric-shim.github.io/ChaincodeInterface.html

#创建nodejs工程+智能合约
mkdir demowork
cd demowork
mkdir chaincode
cd chaincode
mkdir demo01
cd demo01
npm init
npm install --save fabric-shim
#dev模式
vim package.json
"scripts": {
    "start": "node chaincode01.js"
  }

#配置fabric工具环境变量
export PATH=$PATH:/root/fabric-samples/bin

#导入导出文件
rz
sz

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
configtxgen -profile TestOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

#生成通道文件
configtxgen -profile TestOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID FishLocalProInitChannel

#更新锚节点
# 每个组织都对应一个锚节点的更新文件
#go组织锚节点文件
configtxgen -profile TestOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/GoMSPAnchors.tx -channelID FishLocalProInitChannel -asOrg OrgGoMSP

#cpp组织锚节点文件
configtxgen -profile TestOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/CppMSPAnchors.tx -channelID FishLocalProInitChannel -asOrg OrgCppMSP

#docker-compose-cli.yaml配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/first-network/docker-compose-cli.yaml
#docker-compose-base.yaml配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/first-network/base/docker-compose-base.yaml
#peer-base.yaml配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/first-network/base/peer-base.yaml
#fabric-ca配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/basic-network/docker-compose.yaml

#修改fabric-ca配置
sudo cp /home/roger/hyperledger-fabric/fabric-samples/basic-network/docker-compose.yaml ~/testwork/

#testwork与文件夹同名
CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=demowork_byfn

#创建base文件夹存放peer-base.yaml+docker-compose-base.yaml
mkdir base
mv docker-compose-base.yaml peer-base.yaml ./base

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
docker volume prune
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
peer channel create -o orderer.test.com:7050 -c FishLocalProInitChannel -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem

#客户端cli操作peer节点
#加入通道
peer channel join -b FishLocalProInitChannel.block
peer channel join -b testchannel.block
peer channel list

#修改cli客户端环境变量，切换cli节点容器连接的peer节点
envChange.sh
#查看cli客户端连接的是哪个peer节点
echo $CORE_PEER_ADDRESS
#查看cli客户端连接的是哪个组织节点
echo $CORE_PEER_LOCALMSPID

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
peer chaincode install -n testgochaincode -v 1.0 -l golang -p github.com/chaincode
peer chaincode install -n testnodechaincode -v 1.0 -l node -p github.com/chaincode

#修改cli客户端环境变量，切换cli节点容器连接的peer节点
envChange.sh
#查看cli客户端连接的是哪个peer节点
echo $CORE_PEER_ADDRESS
#查看cli客户端连接的是哪个组织节点
echo $CORE_PEER_LOCALMSPID

#链码初始化
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C testchannel -n testnodechaincode -l node -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('OrgGoMSP.member', 'OrgCppMSP.member')"
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C testchannel -n testnodechaincode -l node -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "OR ('OrgGoMSP.member')"
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C testchannel -n testnodechaincode -l node -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('OrgGoMSP.member')"
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C myc -n mycc -l golang -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C myc -n mycc -l node -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"

#锚节点更新(可选）
#修改cli客户端环境变量，切换cli节点容器连接的peer节点
envChange.sh
#查看cli客户端连接的是哪个peer节点
echo $CORE_PEER_ADDRESS
#查看cli客户端连接的是哪个组织节点
echo $CORE_PEER_LOCALMSPID
#更新锚节点
peer channel update -o orderer.test.com:7050 -c testchannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/CppMSPAnchors.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem
peer channel update -o orderer.test.com:7050 -c testchannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/GoMSPAnchors.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem

#查询链码
peer chaincode query -C testchannel -n testgochaincode -c '{"Args":["query","a"]}'
#调用链码
peer chaincode invoke -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem -C testchannel -n testgochaincode --peerAddresses peer0.orggo.test.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/orggo.test.com/tlsca/tlsca.orggo.test.com-cert.pem    --peerAddresses peer0.orgcpp.test.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/orgcpp.test.com/tlsca/tlsca.orgcpp.test.com-cert.pem -c '{"Args":["invoke","a","b","10"]}'

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

#查看couchdb的web界面
ip:5984/_utils
设置用户名+密码
输入用户名+密码



#############Demo01_LocalProInitGo
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
configtxgen -profile TestOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel02

#更新锚节点
# 每个组织都对应一个锚节点的更新文件
#go组织锚节点文件
configtxgen -profile TestOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org01MSPAnchors.tx -channelID mychannel02 -asOrg Org01MSP

#testwork与文件夹同名
CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=demo01_byfn

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
peer channel create -o orderer.test.com:7050 -c mychannel02 -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem

#客户端cli操作peer节点
#加入通道
peer channel join -b mychannel02.block
peer channel list

#安装链码
#-p	从$GOPATH/src 路径后开始写
peer chaincode install -n mychaincode02 -v 1.0 -l golang -p github.com/chaincode

#链码初始化
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C mychannel02 -n mychaincode02 -l golang -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"

#查询链码
peer chaincode query -C mychannel02 -n mychaincode02 -c '{"Args":["query","a"]}'
peer chaincode query -C mychannel02 -n mychaincode02 -c '{"Args":["query","b"]}'

#调用链码
#peer chaincode invoke -o orderer节点地址:端口 --tls true --cafile orderer节点pem格式的证书文件 -C 通道名称 -n 链码名称 --peerAddresses 背书节点1:端口 --tlsRootCertFiles 背书节点1的TLS根证书    --peerAddresses 背书节点2:端口 --tlsRootCertFiles 背书节点2的TLS根证书 -c 交易链码调用
peer chaincode invoke -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem -C mychannel02 -n mychaincode02 --peerAddresses peer0.org01.test.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org01.test.com/tlsca/tlsca.org01.test.com-cert.pem -c '{"Args":["invoke","a","b","10"]}'

#############Demo02_LocalProInitGoCa
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

#############Demo03_LocalProInitGoCaCouch
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
configtxgen -profile TestOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel06

#更新锚节点
# 每个组织都对应一个锚节点的更新文件
#go组织锚节点文件
configtxgen -profile TestOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org01MSPAnchors.tx -channelID mychannel06 -asOrg Org01MSP

#testwork与文件夹同名
CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=demo03_byfn

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
peer channel create -o orderer.test.com:7050 -c mychannel06 -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem

#客户端cli操作peer节点
#加入通道
peer channel join -b mychannel06.block
peer channel list

#安装链码
#-p	从$GOPATH/src 路径后开始写
peer chaincode install -n mychaincode06 -v 1.0 -l golang -p github.com/chaincode

#链码初始化
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C mychannel06 -n mychaincode06 -l golang -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"

#查询链码
peer chaincode query -C mychannel06 -n mychaincode06 -c '{"Args":["query","a"]}'
peer chaincode query -C mychannel06 -n mychaincode06 -c '{"Args":["query","b"]}'

#调用链码
#peer chaincode invoke -o orderer节点地址:端口 --tls true --cafile orderer节点pem格式的证书文件 -C 通道名称 -n 链码名称 --peerAddresses 背书节点1:端口 --tlsRootCertFiles 背书节点1的TLS根证书    --peerAddresses 背书节点2:端口 --tlsRootCertFiles 背书节点2的TLS根证书 -c 交易链码调用
peer chaincode invoke -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem -C mychannel06 -n mychaincode06 --peerAddresses peer0.org01.test.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org01.test.com/tlsca/tlsca.org01.test.com-cert.pem -c '{"Args":["invoke","a","b","10"]}'

#查看couchdb的web界面
ip:5984/_utils
设置用户名+密码
输入用户名+密码

#############Demo04_LocalProInitNodeCaCouch
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

#testwork与文件夹同名
CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=demo05-01_byfn

#创建base文件夹存放peer-base.yaml+docker-compose-base.yaml
mkdir base
mv docker-compose-base.yaml peer-base.yaml ./base

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
docker volume prune
#删除所有docker网络缓存
docker network prune
docker network ls

#进入cli容器
docker exec -it cli bash

#客户端cli
#创建通道
peer channel create -o orderer.test.com:7050 -c myc -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/tlsca/tlsca.test.com-cert.pem

#客户端cli操作peer节点
#加入通道
peer channel join -b myc.block
peer channel list

#安装链码
#-p	从$GOPATH/src 路径后开始写
peer chaincode install -n mycc -v 1.0 -l node -p /opt/gopath/src/github.com/chaincode

#链码初始化
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C myc -n mycc -l node -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"

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

#############Demo05_LocalDevInitGoDemo
#拷贝chaincode-docker-devmode
sudo cp /home/roger/hbhfabric/hyperledger-fabric/fabric-samples/chaincode-docker-devmode/ 
#创建chaincode存放测试调试chaincode
mkdir chaincode

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
docker kill $(docker ps -q)
#删除dev容器镜像
docker rmi $(docker images dev-* -q)
docker volume prune
#删除所有docker网络缓存
docker network prune
docker network ls

#进入chaincode容器
docker exec -it chaincode bash
cd mycc01
go build -o mycc01
CORE_PEER_ADDRESS=peer:7052 CORE_CHAINCODE_ID_NAME=mycc:1.0 ./mycc01
CORE_PEER_ADDRESS=peer:7052 CORE_CHAINCODE_ID_NAME=mycc:1.0 go run chaincode_example02.go

#进入cli容器
docker exec -it cli bash
#安装链码
peer chaincode install -p chaincodedev/chaincode/mycc01 -n mycc -v 1.0
#初始化链码
peer chaincode instantiate -n mycc -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -C myc -c '{"Args":["init","a","100","b","200"]}' -P "AND ('DEFAULT.member')"

#查询链码
peer chaincode query -C myc -n mycc -c '{"Args":["query","a"]}'
peer chaincode query -C myc -n mycc -c '{"Args":["query","b"]}'

#调用链码
#peer chaincode invoke -o orderer节点地址:端口 --tls true --cafile orderer节点pem格式的证书文件 -C 通道名称 -n 链码名称 --peerAddresses 背书节点1:端口 --tlsRootCertFiles 背书节点1的TLS根证书    --peerAddresses 背书节点2:端口 --tlsRootCertFiles 背书节点2的TLS根证书 -c 交易链码调用
peer chaincode invoke -C myc -n mycc -c '{"Args":["invoke","a","b","10"]}'

#参考博客
https://blog.csdn.net/zhayujie5200/article/details/84561825
https://blog.csdn.net/neosmith/article/details/80020740

#############Demo06_LocalDevInitGoCaCouch

#docker-compose启动容器
docker-compose -f docker-compose-cli.yaml up -d
docker-compose up -d
docker-compose up 
#查看docker-compose启动容器情况
docker-compose -f docker-compose-cli.yaml ps
docker-compose ps -a
docker-compose ps
#关闭docker-compose启动容器
docker-compose -f docker-compose-cli.yaml down -v
docker-compose down -v
docker-compose down 
#先暂停所有容器，再移除所有容器
docker stop hash
docker stop $(docker ps -aq)
#删除所有容器
docker rm -f $(docker ps -aq)
docker rm $(docker ps -a -q)
docker kill $(docker ps -q)
#删除dev容器镜像
docker rmi $(docker images dev-* -q)
#删除所有docker网络缓存
docker network prune
docker volume prune
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
peer chaincode instantiate -n mycc -l node -v 1.0 -C myc -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"
peer chaincode instantiate -n mycc -l node -v 1.0 -C myc -c '{"Args":[""]}' -P "AND ('Org01MSP.member')"

#查询链码
peer chaincode query -C myc -n mycc -c '{"Args":["query","a"]}'
peer chaincode query -C myc -n mycc -c '{"Args":["query","b"]}'
peer chaincode query -C myc -n mycc -c '{"function":"queryFish","Args":["FISH1"]}'
peer chaincode query -C myc -n mycc -c '{"function":"queryAllFish","Args":[""]}'

#调用链码
#peer chaincode invoke -o orderer节点地址:端口 --tls true --cafile orderer节点pem格式的证书文件 -C 通道名称 -n 链码名称 --peerAddresses 背书节点1:端口 --tlsRootCertFiles 背书节点1的TLS根证书    --peerAddresses 背书节点2:端口 --tlsRootCertFiles 背书节点2的TLS根证书 -c 交易链码调用
peer chaincode invoke -C myc -n mycc -c '{"Args":["invoke","a","b","10"]}'
peer chaincode invoke -C myc -n mycc -c '{"function":"initLedger","Args":[""]}'

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


######################################Demo07_LocalDevInitNodeCaCouch
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

#创建chaincode目录+安装chaincode依赖
mkdir chaincode
cd chaincode
mkdir mycc
cd mycc
npm init
npm install --save fabric-shim

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

CORE_CHAINCODE_ID_NAME="mycc:1.0"  npm start -- --peer.address grpc://172.17.0.1:7052

#进入cli容器
docker exec -it cli bash
#安装链码
peer chaincode install -p /opt/gopath/src/chaincodedev/chaincode/mycc -n mycc -v 1.0 -l node
#初始化链码
peer chaincode instantiate -n mycc -l node -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -C myc -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"

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
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C myc -n mycc -l node -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"

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

######################################Demo08_LocalDevCodeNodeCaCouchNodeSDK
#安装fabric-ca-client和fabric-client
npm init
npm install --save fabric-ca-client 
npm install --save fabric-client 
npm install --save grpc
npm install --save express 
npm cache clean --force

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
#先暂停所有容器，再移除所有容器
docker stop hash
docker stop $(docker ps -aq)
#删除所有容器
docker rm -f $(docker ps -aq)
docker rm $(docker ps -a -q)
docker kill $(docker ps -q)
#删除dev容器镜像
docker rmi $(docker images dev-* -q)
#删除所有docker网络缓存
docker network prune
docker volume prune
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

#创建chaincode目录+安装chaincode依赖
mkdir chaincode
cd chaincode
mkdir mycc
cd mycc
npm init
npm install --save fabric-shim

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

CORE_CHAINCODE_ID_NAME="mycc:1.0"  npm start -- --peer.address grpc://172.17.0.1:7052

#进入cli容器
docker exec -it cli bash
#安装链码
peer chaincode install -p /opt/gopath/src/chaincodedev/chaincode/mycc -n mycc -v 1.0 -l node
#初始化链码
peer chaincode instantiate -n mycc -l node -v 1.0 -C myc -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"
peer chaincode instantiate -n mycc -l node -v 1.0 -C myc -c '{"Args":[""]}' -P "AND ('Org01MSP.member')"
peer chaincode invoke -C myc -n mycc -c '{"function":"initLedger","Args":[""]}'

#查询链码
peer chaincode query -C myc -n mycc -c '{"Args":["query","a"]}'
peer chaincode query -C myc -n mycc -c '{"Args":["query","b"]}'
peer chaincode query -C myc -n mycc -c '{"function":"queryFish","Args":["FISH1"]}'
peer chaincode query -C myc -n mycc -c '{"function":"queryAllFish","Args":[""]}'

#调用链码
#peer chaincode invoke -o orderer节点地址:端口 --tls true --cafile orderer节点pem格式的证书文件 -C 通道名称 -n 链码名称 --peerAddresses 背书节点1:端口 --tlsRootCertFiles 背书节点1的TLS根证书    --peerAddresses 背书节点2:端口 --tlsRootCertFiles 背书节点2的TLS根证书 -c 交易链码调用
peer chaincode invoke -C myc -n mycc -c '{"Args":["invoke","a","b","10"]}'


#webapp
node enrollAdmin.js
node enrollUser.js
node query.js queryFish "FISH1"
node query.js queryAllFish ""  

#参考博客
https://blog.csdn.net/zhayujie5200/article/details/84561825
https://blog.csdn.net/neosmith/article/details/80020740

######################################原始链码安装
#安装链码
#-p	从$GOPATH/src 路径后开始写
peer chaincode install -n mycc -v 1.0 -l golang -p github.com/chaincode

#链码初始化
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C myc -n mycc -l golang -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"
peer chaincode instantiate -o orderer.test.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/test.com/msp/tlscacerts/tlsca.test.com-cert.pem  -C myc -n mycc -l node -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('Org01MSP.member')"

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

######################################GoLocal01_SingleMachineMultiNode
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
configtxgen -profile smmnOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

#生成通道文件
configtxgen -profile smmnOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

#更新锚节点
# 每个组织都对应一个锚节点的更新文件
#go组织锚节点文件
configtxgen -profile smmnOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/GoMSPAnchors.tx -channelID mychannel -asOrg OrgGoMSP

#cpp组织锚节点文件
configtxgen -profile smmnOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/CppMSPAnchors.tx -channelID mychannel -asOrg OrgCppMSP

#docker-compose-cli.yaml配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/first-network/docker-compose-cli.yaml
#docker-compose-base.yaml配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/first-network/base/docker-compose-base.yaml
#peer-base.yaml配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/first-network/base/peer-base.yaml
#fabric-ca配置文件模板
/home/roger/hyperledger-fabric/fabric-samples/basic-network/docker-compose.yaml

#smmnwork与文件夹同名
CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=smmn_byfn

#创建base文件夹存放peer-base.yaml+docker-compose-base.yaml
mkdir base
mv docker-compose-base.yaml peer-base.yaml ./base

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
peer channel create -o orderer.smmn.com:7050 -c mychannel -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/smmn.com/tlsca/tlsca.smmn.com-cert.pem

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
peer channel update -o orderer.smmn.com:7050 -c mychannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/CppMSPAnchors.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/smmn.com/tlsca/tlsca.smmn.com-cert.pem
peer channel update -o orderer.smmn.com:7050 -c mychannel -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/GoMSPAnchors.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/smmn.com/tlsca/tlsca.smmn.com-cert.pem

#chaincode模板
/home/roger/hyperledger-fabric/fabric-samples/chaincode
/home/roger/hyperledger-fabric/fabric-samples/chaincode/chaincode_example02/go
#创建chaincode文件文件夹，存放chaincode
mkdir chaincode
#拷贝chaincode文件至chaincode文件夹
sudo cp chaincode_example02.go ~/smmnwork/chaincode/
sudo mv chaincode_example02.go smmngochaincode.go

#安装链码
#-p	从$GOPATH/src 路径后开始写
peer chaincode install -n smmnchaincode -v 1.0 -l golang -p github.com/chaincode

#修改cli客户端环境变量，切换cli节点容器连接的peer节点
envChange.sh
#查看cli客户端连接的是哪个peer节点
echo $CORE_PEER_ADDRESS
#查看cli客户端连接的是哪个组织节点
echo $CORE_PEER_LOCALMSPID

#链码初始化
peer chaincode instantiate -o orderer.smmn.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/smmn.com/msp/tlscacerts/tlsca.smmn.com-cert.pem  -C mychannel -n smmnchaincode -l golang -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "AND ('OrgGoMSP.member', 'OrgCppMSP.member')"

#查询链码
peer chaincode query -C mychannel -n smmnchaincode -c '{"Args":["query","a"]}'
peer chaincode query -C mychannel -n smmnchaincode -c '{"Args":["query","b"]}'

#调用链码
peer chaincode invoke -o orderer.smmn.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/smmn.com/tlsca/tlsca.smmn.com-cert.pem -C mychannel -n smmnchaincode --peerAddresses peer0.orggo.smmn.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/orggo.smmn.com/tlsca/tlsca.orggo.smmn.com-cert.pem --peerAddresses peer0.orgcpp.smmn.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/orgcpp.smmn.com/tlsca/tlsca.orgcpp.smmn.com-cert.pem -c '{"Args":["invoke","a","b","10"]}'

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
docker volume prune
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