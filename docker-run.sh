docker run --restart=always --name=myapp -e DB_REMOTE_ROOT_PASS=12345678 -p 3302:80 -v /var/data/myapp:/var/data/myapp ubuntu-1804-python36
