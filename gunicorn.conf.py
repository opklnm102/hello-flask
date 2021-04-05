import multiprocessing

name = "hello-flask"
bind = ":5000"
workers = multiprocessing.cpu_count() * 2 + 1
keepalive = 60
worker_connections = 1000 * workers
worker_class = "sync"
reload = True
loglevel = "info"
logfile = "-"
spew = False

max_requests = 1000
max_requests_jitter = 50
graceful_timeout = 15
timeout = 30
