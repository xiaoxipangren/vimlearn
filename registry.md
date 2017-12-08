#### 记录成功进行Docker私有镜像仓库搭建的过程 ####
1 概要
    成功部署一个私有的外部可访问的具有权限控制的Docker镜像仓库，主要有包括证书的生成与部署，registry镜像启动等操作，相对来说步骤很是麻烦，现记录如下。
2 步骤
    2.1证书生成与部署
        证书主要用来对registry进行https加密。由于申请第三方证书比较麻烦，因此采用自签名证书。同时为了避免每生成一个证书便部署一次，采用生成自己的根CA。
        2.1.1 生成CA
            openssl genrsa -out ca.key 2048 #生成CA密钥对
            openssl req -x509 -new -key ca.key -out ca.crt -days 3650 -subj /CN="NationalChip CA" #根据CA的密钥对生成CA证书，注意这个证书ca.crt以后需要用来签署其他证书，并要作为根证书导入到需要部署的Host上。
            典型情况下，CA的证书ca.crt需要导入到Host，以使Host信任所有ca.key签发的证书。ca.key则用于签发证书。

        2.1.2 生成密钥对和签名认证申请
            同生成CA证书一样，首先生成密钥对
            openssl genrsa -out cert.key 2048
            与CA证书不同的是，第二步生成一个签名请求文件，这里引入一个变量和证书绑定的域名 
            export domain=registry.nationalchip.com #要绑定的域名
            openssl req -new -out cert.csr -key cert.key -subj /CN=registry.nationalchip.com #根据密钥对和域名生成签名申请
        2.1.3 CA认证CSR并签署证书
            openssl x509 -req -in cert.csr -out cert.crt -CAkey ca.key #CA使用自己的私钥加密CSR以签署证书。
        2.1.4 证书的部署
            得到证书后将cert.key和cert.crt部署到网站，可以进行Https加密操作。
            整个流程可以这么理解。Host信任CA，并且拥有CA的公钥。数字证书cert.crt是CA用自己的私钥加密cert.key公钥得到的内容。在通信时，Server将cert.crt发送到Host，Host认识到这是CA签署的证书，由于信任这个CA，便也信任这个证书。Host使用CA的公钥解密证书，得到证书中的公钥，之后Server使用自己证书的私钥与host得到的公钥进行身份验证，完成握手操作。（这个要画流程图）

    2.2 部署Registry镜像
        2.2.1 生成用户/密码信息
            使用htpasswd工具生成用户名和密码hash的文件
            htpasswd -Bbn username password > auth/htpasswd
        2.2.2 运行registry镜像
            首先将1中得到的证书和私钥文件拷贝到当前目录的certs目录下，使用如下操作运行Docker镜像

            docker run -d \
            --restart=always \
            --name registry \
            -v `pwd`/auth:/auth \
            -e "REGISTRY_AUTH=htpasswd" \
            -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
            -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
            -v `pwd`/certs:/certs \
            -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
            -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/cert.cer \
            -e REGISTRY_HTTP_TLS_KEY=/certs/cert.key \
            -p 443:443 \
            registry:2

    2.3 Host导入CA证书
        在Host的/usr/share/ca-certificates中建立目录ca，并将CA.crt放入到ca中
            sudo mkdir -p /usr/share/ca-certificates/ca && sudo cp ca.crt /usr/share/ca-certificates/ca

        更新/etc/ca-certificates.conf，在其末尾添加一行
            ca/ca.crt #上面去掉/usr/share/ca-certificates的相对路径
            
        update使证书生效
            update-ca-certificates
        
        Host端重启docker，使其加载该CA证书
            sudo service docker restart

    2.4 Host更新hosts文件
        主要上文我们使用的是域名绑定证书，内网环境下如果没有dns服务器支持，需要在本地将域名解析成registry所在主机的ip。在host上的/etc/hosts文件中追加如下行：
            $domain xx.xx.xx.xx
            
        自此，所有配置都已完成，可以在Host进行如下操作：
            docker login $domain
        如无错误，将会让输入用户名和密码，便可以向该私有regsitry推送docker镜像。

