#拷贝chaincode-docker-devmode
sudo cp /home/roger/hbhfabric/hyperledger-fabric/fabric-samples/chaincode-docker-devmode/ 
#创建chaincode存放测试调试chaincode
mkdir chaincode

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