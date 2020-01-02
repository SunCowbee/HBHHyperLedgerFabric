###问题一：

1，hyperledger-fabric在开启多个服务的时候，可能会报端口占用的问题，关闭虚拟机，重开docker-compose up -d。

### 问题二：

2，hyperledger-fabric在开启cli的时候，出现如下错误，说明cli重名，修改cli名称
```
ERROR: for cli  Cannot create container for service cli: Conflict. The container name "/cli" is already in use by container "622a6328af66b79613b78fdd69373e1d410ab9c2adc58db004c287dedc213402". You have to remove (or rename) that container to be able to reuse that name.
```

![](.\pic\cli重名错误.png)

![](.\pic\cli名称修改.png)

### 注意

开启docker-compose

```
docker-compose up -d
```

关闭docker-compose

```
docker-compose down -v
```

