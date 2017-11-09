#### docker 学习笔记 ####
### 基本概念 ###
    1.image container service
        1.1 image 如字面意思，image为镜像，可以理解为包含代码、文件等内容的资源包，本质上是一些列文件的集合，是一个压缩文件
        
        1.2 container 容器，是image加载到内存后运行的实例，可以理解为运行中的程序

        1.3 service 将一组container编排起来进行扩展就组成了一个service，docker使用compose.yml文件定义service，包括网络、container复制数量、每个container实例内存/cpu资源、重启策略等。注意service更多意义上是逻辑上的概念，表示的是某一个imange的多container实例的集合
             
        1.4 cluster  运行了docker实例的多个物理或者虚拟主机的集合，是一个物理概念，可以用docker-machine命令基于不同的虚拟机驱动方便的创建docker虚拟机。集群是一个物理概念。
            
        1.5 swarm 将运行docker的集群中的各个主机使用docker swarm init/join等命令组织起来便形成了逻辑上的"蜂巢"，其中运行init命令的是manager node，运行join命令的是worker node。“工蜂”“王蜂”相互配合形成一个蜂巢系统，以高效率的均衡各service的负载。也就说swarm是一个基础实施层上的概念

        1.6 stack 对于一个完整的系统来说，总是需要多个service的配合，如数据库、web框架、jdk等，这些service相互存在依赖关系，这些相互依赖的service组成的一个复杂的系统称之为一个stack，换句话说，stack是一组service编排后的结果。

        总结：
        从两个层面来理解这些概念。以基础设施的角度看，cluster是简单的运行了docker的主机的集合，而swarm是这些主机有机组织起来的集合，其中有一个主机确定为管理员的角色，而其他主机为工作器的角色。从应用的角度看，image是一些元信息的物理存储，container是image的运行时形态，service是container分布式扩展的结果，而stack则是多个service编排组织后的结果。
        可以类比编程中的工作。编程实际上可以理解为在可用api依赖的基础上进行的编排动作，在外加上一些数据。同样在大型应用的部署分发中也是在各种应用依赖(service)上的编排，除却自己开发的应用，还可能依赖数据库、第三方库等。这个意义上，docker是在利用编程的方式来简化大型应用的部署、分发、扩展和负载均衡。
        docker常用命令：
        docker run/pull/tag/push
        docker build #通过源文件生成image
        docker image ls/rm
        docker container stop/start/ls/kill/rm
        docker service ls/ps
        docker swarm init/join/leave
        docker-machine start/stop/rm/create/env/ssh/scp
        docker node ls
        docker stack deploy -c composite.yml <app-name>

