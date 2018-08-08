### jwt token认证 

1.jwt token放篡改机制
    jwt在服务端会使用一个secret字符串对payload字符串进行签名，并附着在jwt中。如果客户端篡改payload并重新签名，因为无法获知签名secret因此必定无法通过服务端效验。
