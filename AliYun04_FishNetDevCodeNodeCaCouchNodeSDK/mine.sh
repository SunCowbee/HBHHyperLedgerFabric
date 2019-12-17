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
