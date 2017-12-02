#### git 学习记录 ####

### 1.git 基本原理
    1.1 git基本对象
        commit 提交对象，包含提交作者信息、提交日期、提交日志以及指向本次提交顶级目录tree指针、指向父级提交指针等信息
        tree 目录树对象，存储包含了指向blob的指针，以及blob的文件名、权限等信息的记录，或者是指向子目录树的记录
        blob 块对象存储文件内容
        tag 标签，指向提交的具有可读名字的静态指针，可以认为tag是branch的静态版本，也就是说一旦创建，tag中指向commit的指针永远不会再改变
        branch 一个指向最后一次提交产生的commit对象的可变指针，由于commit对象包含指向父级提交的指针，因此通过一个branch指针便可追踪出一个提交记录链，就称之为分支，branch中的commit指针会随着新的提交不断改变，保持指向最新的commit
        HEAD head是一个指示当前仓库所处分支的一个文本文件，checkout指向一个新分支的实质是将HEAD中的内容修改为新分支名

        git的整体目录可用如下图表示：
        ![](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510285912645&di=7f188a2bc73aaf0c36b142e9d1d04e64&imgtype=0&src=http%3A%2F%2Fimage.lxway.com%2Fupload%2Fd%2Fcc%2Fdccafadf1371c5b4abd90b4ad1375c22_thumb.jpg)

    1.2 git对象模型与提交原理
        git是如何记录源代码的内容、层次结构（目录结构）的变化的呢，又是如何实现回退的呢？以及git中引入的stage中间态又有什么意义？

        把一个git仓库拆分成工作目录、索引和对象库三个部分来看待。索引也是一个tree对象，在一个clean的仓库中，索引存储的blob指针记录以及与指针关联的路径和文件名信息与工作目录的物理组成是一致的，索引tree和当前branch 指针指向commit对象指向的tree是相同的，他们具有相同的blog记录。当修改文件内容后，git如何识别未staged的更改呢？原理是检查工作目录中文件的hash和索引tree具有相同文件名的blob hash是否相同，注意此时索引tree和提交tree还是相同的。执行git add后，git将根据工作目录中的新文件的hash值更新索引tree中的bolb指针记录，重新指向新的blob。这时工作目录和索引tree相同，而索引tree和提交tree不同，此时状态为未提交。执行git commit后，git将根据索引tree生成一个新的提交tree，同时生成一个新的commit对象，该commit对象指向新tree，并拥有一个指向父commit的指针，最后更新branch指针指向最新的commit。此后，工作目录、索引tree和对象库的内容又完全一致了。 

    1.3 git多账号配置
        1.3.1 ssh与git
            ssh是一种安全远程登录协议，
### 2.git 操作 ###
    2.1 diff 
        git diff 比较工作目录和索引的不同
        git diff {commit} 比较工作目录和某一次提交的不同
        git diff --cached {commit} 比较索引和某一次提交的不同
        git diff commit1 commit2 比较两次提交之间的不同
