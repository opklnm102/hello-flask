import multiprocessing

wsgi_app = "wsgi:application"
name = "hello-flask"

# https://stackoverflow.com/questions/19916016/gunicorn-nginx-server-via-socket-or-proxy
# web server(nginx) + app server(wsgi) in same server => unix socket
# web server(nginx) + app server(wsgi) in network => TCP port
bind = ":5000"

workers = multiprocessing.cpu_count() * 2 + 1
keepalive = 60
worker_connections = 1000 * workers
worker_class = "sync"

reload = True

loglevel = "info"
logfile = "-"

spew = False

# max_requests(default. 0)
# max_requests만큼 처리하면 restart worker process
# memory leak 원인 파악이 어려울 때 유용
max_requests = 1000
max_requests_jitter = 50
graceful_timeout = 15
timeout = 30
