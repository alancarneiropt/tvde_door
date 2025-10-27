# Configuração Gunicorn para TVDE Door
# Arquivo: gunicorn.conf.py

import multiprocessing

# Configurações básicas
bind = "0.0.0.0:8006"
workers = multiprocessing.cpu_count() * 2 + 1
worker_class = "sync"
worker_connections = 1000
timeout = 30
keepalive = 2

# Configurações de logging
accesslog = "-"
errorlog = "-"
loglevel = "info"
access_log_format = '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"'

# Configurações de segurança
limit_request_line = 4094
limit_request_fields = 100
limit_request_field_size = 8190

# Configurações de performance
max_requests = 1000
max_requests_jitter = 100
preload_app = True

# Configurações específicas para site estático
forwarded_allow_ips = "*"
secure_scheme_headers = {
    'X-FORWARDED-PROTO': 'https',
}

# Configurações de timeout
graceful_timeout = 30
worker_tmp_dir = "/dev/shm"

print("🔧 Gunicorn configurado para porta 8006")
print(f"👥 Workers: {workers}")
print(f"🌐 Bind: {bind}")
print(f"⏱️ Timeout: {timeout}s")
