###Discourse安装文档

1.使用discourse安装目录中的app.yml进行邮件配置
2.参考https://meta.discoursecn.org/t/topic/28进行阿里云特殊配置，更改app.yml文件
3.discourse数据映射在host的/var/discourse中
4.docker镜像启动后在镜像内部执行 rails r "SiteSetting.notification_email='zhenghq@nationalchip.com'"，设置通知邮件的发送邮箱，否则无法收到管理员注册验证邮件
5.如果需要将discourse部署至非80端口，在app.yml中的hostname也应写上端口，ip:port

