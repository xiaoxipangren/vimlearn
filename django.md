### django部署

1.uwsgi
    uwsgi可以高效的运行django程序，支持以http和socket方式进行部署，当与nginx配合时使用socket方式，以确保所有流量通过nginx转发，一个典型的uwsgi配置文件：
    [uwsgi]

    # Django-related settings

    socket = 127.0.0.1:8083

    # the base directory (full path)
    chdir           = /home/zhenghq/python/running/console

    # Django s wsgi file
    module          = running.wsgi
    
    # process-related settings
    # master
    master          = true

    # maximum number of worker processes
    processes       = 4

    # ... with appropriate permissions - may be needed
    # chmod-socket    = 664
    # clear environment on exit
    vacuum          = true

    enable-threads  = true
    buffer-size     = 32768
2.nginx配置
    
    重点注意url重写
    location /wechat{
          rewrite ^/wechat(.*)$ $1 break;
          include uwsgi_params;
       
          uwsgi_pass 127.0.0.1:8083;
       
          uwsgi_read_timeout 30;
      }


